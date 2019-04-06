//
//  App.swift
//  KCProgrammingApp
//
//  Created by student on 3/14/19.
//  Copyright © 2019 Badisa,Sairam. All rights reserved.
//

import Foundation

class Schools{
    
    let backendless = Backendless.sharedInstance()!
    var schoolsDataStore:IDataStore!
    var teamsDataStore:IDataStore!

    var schools:[School]
    var teams:[Team]

    static var shared = Schools()
    
    var teamsForSelectedSchools: [Team] = []
    
    
    init(schools: [School]) {
        
        self.schools = schools
        
        self.teams = []
        
        schoolsDataStore = backendless.data.of(School.self)
        
        teamsDataStore = backendless.data.of(Team.self)
        
    }
    
    
    private init(){
        
        schoolsDataStore = backendless.data.of(School.self)
        
        teamsDataStore = backendless.data.of(Team.self)
        
        self.schools = []
        
        self.teams = []
        
    }
    
    
    
    func numSchools() -> Int{
        
        return schools.count
        
    }
    
    
    func numTeams() -> Int {
        
        return teams.count
        
    }
    
    func numTeamsForSelectedSchool() -> Int {
        
        return teamsForSelectedSchools.count
        
    }
    
    subscript(index:Int) -> School {
        
        return schools[index]
        
    }

    
    func saveSchool(name: String, coach: String) {
        
        var schoolToSave = School(name: name, coach: coach, teams: [])
        print(schoolToSave.coach)
        schoolToSave = schoolsDataStore.save(schoolToSave) as! School
        schools.append(schoolToSave)
        
    }
    
    
    
    func saveTeamForSelectedSchool(school: School, team:Team) {
        
        print("Saving the team for the selected school")
        
        Types.tryblock({
            
            let savedTeam = self.teamsDataStore.save(team) as! Team
            
            self.schoolsDataStore.addRelation("team:Team:n", parentObjectId: school.objectId, childObjects: [savedTeam.objectId!])
            
        }, catchblock:{ (exception) -> Void in
            
            print(exception.debugDescription)
            
        })
        
        school.teams.append(team)
        
        print("Done!!")
        
    }
    
    
    
    func retrieveAllSchools() {
        
        let queryBuilder = DataQueryBuilder()
        
        queryBuilder!.setRelated(["teams"])
        
        queryBuilder!.setPageSize(100)
        
        Types.tryblock({() -> Void in
            
            self.schools = self.schoolsDataStore.find(queryBuilder) as! [School]
            
        },
                       
                       catchblock: {(fault) -> Void in print(fault ?? "Something has gone wrong  reloadingAllSchools()")}
            
        )
        
    }
    
    
    
    func retrieveTeamsForSelectedSchool(school: School) {
        
        Types.tryblock( {
            
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            
            queryBuilder.setWhereClause("name = '\(school.name! )'" )
            
            queryBuilder.setPageSize(100)
            
            queryBuilder.setRelated( ["team"] )
            
            let result = self.schoolsDataStore.find(queryBuilder) as! [School]
            
            self.teamsForSelectedSchools = result[0].teams
            
        },
                        
                        catchblock: {(exception) -> Void in
                            
                            print("Oops! retrieving teams for selected school -- \(exception.debugDescription)")
                            
        })
        
    }
    
    
    func deleteSchool(school: School){
        
        
        
        let num = schoolsDataStore.remove(school)
        
        for i in 0 ..< schools.count {
            
            if schools[i] == school {
                
                schools.remove(at:i)
                
                break
                
            }
            
        }
        
    }
    
}


@objcMembers
class School: NSObject{
    
    var name: String?
    
    var coach: String
    
    var teams: [Team]

    override var description: String { // NSObject adheres to the CustomStringConvertible protocol
        
        return "Name: \(name ?? ""), Coach: \(coach), ObjectId: \(objectId ?? "N/A")"
        
    }
    
    var objectId:String?
    
    
    
    func addTeam(name: String, students: [String]){
        
        teams.append(Team(name: name, students: students))
        
    }
    
    init(name: String, coach: String, teams: [Team]) {
        
        self.name = name
        
        self.coach = coach
        
        self.teams = teams
        
    }
    
    convenience override init(){
        
        self.init(name: "", coach: "", teams: [])
        
    }
    static func == (lhs: School, rhs: School) -> Bool {
        
        return lhs.name == rhs.name && lhs.coach == rhs.coach && lhs.teams == rhs.teams
        
    }
    
}



@objcMembers
class Team : NSObject{
    var name: String?
    
    var students: [String]
    
    override var description: String { // NSObject adheres to the CustomStringConvertible protocol
        
        return "Name: \(name ?? ""), Students: \(students)"
        
    }
    
    var objectId:String?

    init(name: String, students: [String]){
        
        self.name = name
        
        self.students = students
        
    }
    
    
    convenience override init(){
        
        self.init(name: "", students: [])
        
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        
        return lhs.name == rhs.name && lhs.students == rhs.students
        
    }
}
