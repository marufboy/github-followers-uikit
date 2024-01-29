//
//  UserModel.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 29/01/24.
//

import Foundation

struct UserModel: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicrepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
