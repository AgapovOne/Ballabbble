//
//  Shot.swift
//  Ballabbble
//
//  Created by Aleksey Agapov on 01/06/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Marshal

struct Image: Unmarshaling {
    var hidpi: URL?
    var normal: URL
    var teaser: URL

    init(object: MarshaledObject) throws {
        hidpi = try object.value(for: "hidpi")
        normal = try object.value(for: "normal")
        teaser = try object.value(for: "teaser")
    }
}

struct Shot: Unmarshaling {
    var id: Int
    var title: String
    var description: String // Text with html tags

    var image: Image

    var width: Int
    var height: Int

//    var viewsCount: Int
//    var likesCount: Int
//    var commentsCount: Int
//    var attachmentsCount: Int
//    var reboundsCount: Int
//    var bucketsCount: Int

    var created: Date
    var updated: Date

//    var html: URL
//    var attachments: URL
//    var buckets: URL
//    var comments: URL
//    var likes: URL
//    var projects: URL
//    var rebounds: URL

    var isAnimated: Bool
    var tags: [String]

    init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        title = try object.value(for: "title")
        description = try object.value(for: "description")

        image = try object.value(for: "images")

        width = try object.value(for: "width")
        height = try object.value(for: "height")

//        viewsCount = try object.value(for: "views_count")
//        likesCount = try object.value(for: "likes_count")
//        commentsCount = try object.value(for: "comments_count")
//        attachmentsCount = try object.value(for: "attachments_count")
//        reboundsCount = try object.value(for: "rebounds_count")
//        bucketsCount = try object.value(for: "buckets_count")

        created = try object.value(for: "created_at")
        updated = try object.value(for: "updated_at")

//        html = try object.value(for: "html_url")
//        attachments = try object.value(for: "attachments_url")
//        buckets = try object.value(for: "buckets_url")
//        comments = try object.value(for: "comments_url")
//        likes = try object.value(for: "likes_url")
//        projects = try object.value(for: "projects_url")
//        rebounds = try object.value(for: "rebounds_url")

        isAnimated = try object.value(for: "animated")
        tags = try object.value(for: "tags")
    }
}
