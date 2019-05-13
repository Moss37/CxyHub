//
//  Detail.swift
//  CxyHub
//
//  Created by caony on 2019/5/13.
//  Copyright © 2019年 cj. All rights reserved.
//

import HandyJSON
import Foundation

struct Detail: HandyJSON {
      var clone_url: String =  "" 
      var statuses_url: String =  "" 
      var issue_comment_url: String =  "" 
      var issues_url: String =  "" 
      var archived: Bool =  false 
      var default_branch: String =  "" 
      var subscription_url: String =  "" 
      var homepage: String =  "" 
      var downloads_url: String =  "" 
      var fork: Bool =  false 
      var full_name: String =  "" 
      var notifications_url: String =  "" 
      var merges_url: String =  "" 
      var pushed_at: String =  "" 
      var forks_count: Int =  0 
      var owner: DetailOwner = DetailOwner()
      var svn_url: String =  "" 
      var git_commits_url: String =  "" 
      var ssh_url: String =  "" 
      var forks_url: String =  "" 
      var trees_url: String =  "" 
      var issue_events_url: String =  "" 
      var has_pages: Bool =  false 
      var network_count: Int =  0 
      var teams_url: String =  "" 
      var releases_url: String =  "" 
      var has_projects: Bool =  false 
      var forks: Int =  0 
      var contributors_url: String =  "" 
      var stargazers_url: String =  "" 
      var labels_url: String =  "" 
      var mirror_url: Any =  "" 
      var has_wiki: Bool =  false 
      var open_issues: Int =  0 
      var created_at: String =  "" 
      var stargazers_count: Int =  0 
      var language: String =  "" 
      var assignees_url: String =  "" 
      var compare_url: String =  "" 
      var open_issues_count: Int =  0 
      var languages_url: String =  "" 
      var has_issues: Bool =  false 
      var milestones_url: String =  "" 
      var pulls_url: String =  "" 
      var branches_url: String =  "" 
      var url: String =  "" 
      var contents_url: String =  "" 
      var git_url: String =  "" 
      var html_url: String =  "" 
      var git_tags_url: String =  "" 
      var tags_url: String =  "" 
      var git_refs_url: String =  "" 
      var events_url: String =  "" 
      var collaborators_url: String =  "" 
      var disabled: Bool =  false 
      var updated_at: String =  "" 
      var node_id: String =  "" 
      var watchers_count: Int =  0 
      var subscribers_count: Int =  0 
      var hooks_url: String =  "" 
      var watchers: Int =  0 
      var has_downloads: Bool =  false 
      var name: String =  "" 
      var keys_url: String =  "" 
      var deployments_url: String =  "" 
      var private_value: Bool =  false
      var description: String =  "" 
      var archive_url: String =  "" 
    var license: DetailLicense =  DetailLicense()
      var id: Int =  0 
      var blobs_url: String =  "" 
      var size: Int =  0 
      var commits_url: String =  "" 
      var subscribers_url: String =  "" 
      var comments_url: String =  ""
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.private_value <-- "private"
    }
    
    init() {}
}

struct DetailLicense:HandyJSON {
    var key:String = ""
    var name:String = ""
    var spdx_id:String = ""
    var url:String = ""
    var node_id:String = ""
    
    init() {}
}

struct DetailBranch:HandyJSON {
    
    var name:String = ""
    var commit:[String:Any] = [:]
    var protected:Bool = false
    
    init() {}
}

struct DetailCommit:HandyJSON {
    var sha:String = ""
    var url:String = ""
    
    init() {}
}
