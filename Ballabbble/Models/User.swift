//
//  User.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation
import Marshal

struct User: Unmarshaling {
    //        "id" : 1,
    //        "name" : "Dan Cederholm",
    //        "username" : "simplebits",
    //        "html_url" : "https://dribbble.com/simplebits",
    //        "avatar_url" : "https://d13yacurqjgara.cloudfront.net/users/1/avatars/normal/dc.jpg?1371679243",
    //        "bio" : "Co-founder &amp; designer of <a href=\"https://dribbble.com/dribbble\">@Dribbble</a>. Principal of SimpleBits. Aspiring clawhammer banjoist.",
    //        "location" : "Salem, MA",
    //        "links" : {
    //            "web" : "http://simplebits.com",
    //            "twitter" : "https://twitter.com/simplebits"
    //        },
    //        "buckets_count" : 10,
    //        "comments_received_count" : 3395,
    //        "followers_count" : 29262,
    //        "followings_count" : 1728,
    //        "likes_count" : 34954,
    //        "likes_received_count" : 27568,
    //        "projects_count" : 8,
    //        "rebounds_received_count" : 504,
    //        "shots_count" : 214,
    //        "teams_count" : 1,
    //        "can_upload_shot" : true,
    //        "type" : "Player",
    //        "pro" : true,
    //        "buckets_url" : "https://dribbble.com/v1/users/1/buckets",
    //        "followers_url" : "https://dribbble.com/v1/users/1/followers",
    //        "following_url" : "https://dribbble.com/v1/users/1/following",
    //        "likes_url" : "https://dribbble.com/v1/users/1/likes",
    //        "shots_url" : "https://dribbble.com/v1/users/1/shots",
    //        "teams_url" : "https://dribbble.com/v1/users/1/teams",
    //        "created_at" : "2009-07-08T02:51:22Z",
    //        "updated_at" : "2014-02-22T17:10:33Z"

    init(object: MarshaledObject) throws {

    }
}
