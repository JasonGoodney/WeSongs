//
//  User.swift
//  SoundWorld
//
//  Created by Jason Goodney on 10/29/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    let songUid: String
    let locationUid: String
    var latitude: Double
    var longitude: Double
    var isAppleMusicSubscriber: Bool
    var isAnonymous: Bool
    var song: Song
    
    var firebaseDictionary: [String: Any] {
        return [
            // User
            Key.uid: uid,
            Key.email: email,
            Key.songUid: songUid,
            Key.locationUid: locationUid,
            Key.latitude: latitude,
            Key.longitude: longitude,
            Key.isAppleMusicSubscriber: isAppleMusicSubscriber,
            Key.isAnonymous: isAnonymous,
            
            // Song
            SongKey.title: song.title,
            SongKey.artist: song.artist,
            SongKey.spotifyUri: song.spotifyUri as! String,
            SongKey.isSavedToSpotify: song.isSavedToSpotify,
            SongKey.isPaused: song.isPaused,
            SongKey.playbackDuration: song.playbackDuration,
        ]
    }
    
    enum Key {
        
        // Top Level Item
        static let users = "users"
        
        // Properties
        static let uid = "uid"
        static let email = "email"
        static let songUid = "songUid"
        static let locationUid = "locationUid"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let isAppleMusicSubscriber = "isAppleMusicSubscriber"
        static let isAnonymous = "isAnonymous"
    }
    
    enum SongKey {
        
        static let songs = "songs"
        // Properties
        static let uid = "uid"
        static let title = "title"
        static let artist = "artist"
        static let spotifyUri  = "spotifyUri"
        static let isSavedToSpotify = "isSavedToSpotify"
        static let isPaused = "isPaused"
        static let playbackDuration = "playbackDuration"
    }
    
    init(uid: String,
         email: String,
         songUid: String = UUID().uuidString,
         locationUid: String = UUID().uuidString,
         latitude: Double,
         longitude: Double,
         isAppleMusicSubscriber: Bool = false,
         isAnonymous: Bool = true,
         song: Song) {
        
        self.uid = uid
        self.email = email
        self.songUid = songUid
        self.locationUid = locationUid
        self.latitude = latitude
        self.longitude = longitude
        self.isAppleMusicSubscriber = isAppleMusicSubscriber
        self.isAnonymous = isAnonymous
        self.song = song
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return nil }
        
        let uid = value[Key.uid] as? String ?? "uid"
        let email = value[Key.email] as? String ?? "email"
        let songUid = value[Key.songUid] as? String ?? "song uid"
        let locationUid = value[Key.locationUid] as? String ?? "location uid"
        let latitude = value[Key.latitude] as? Double ?? 44
        let longitude = value[Key.longitude] as? Double ?? 122
        let isAppleMusicSubscriber = value[Key.isAppleMusicSubscriber] as? Bool ?? false
        let isAnonymous = value[Key.isAnonymous] as? Bool ?? true
        
 
        self.uid = uid
        self.email = email
        self.songUid = songUid
        self.locationUid = locationUid
        self.latitude = latitude
        self.longitude = longitude
        self.isAppleMusicSubscriber = isAppleMusicSubscriber
        self.isAnonymous = isAnonymous
        
        if let title = value[SongKey.title] as? String,
            let artist = value[SongKey.artist] as? String,
            let uid = value[SongKey.uid] as? String,
            let spotifyUri = value[SongKey.spotifyUri] as? String,
            let isSavedToSpotify = value[SongKey.isSavedToSpotify] as? Bool,
            let isPaused = value[SongKey.isPaused] as? Bool,
            let playbackDuration = value[SongKey.playbackDuration] as? Double {
            
            let song = Song(uid: uid, title: title, artist: artist, spotifyUri: spotifyUri, isSavedToSpotify: isSavedToSpotify, isPaused: isPaused, playbackDuration: playbackDuration)
            
            self.song = song
        } else {
            let emptySong = Song()
            self.song = emptySong
        }
    }
    
    init?(dictionary: [String: Any]) {
        let value = dictionary
        
        let uid = value[Key.uid] as? String ?? UUID().uuidString
        let email = value[Key.email] as? String ?? "\(UUID().uuidString)@email.com"
        let songUid = value[Key.songUid] as? String ?? UUID().uuidString
        let locationUid = value[Key.locationUid] as? String ?? UUID().uuidString
        let latitude = value[Key.latitude] as? Double ?? Double.random(in: 19...122)
        let longitude = value[Key.longitude] as? Double ?? Double.random(in: 19...122)
        let isAppleMusicSubscriber = value[Key.isAppleMusicSubscriber] as? Bool ?? false
        let isAnonymous = value[Key.isAnonymous] as? Bool ?? true
        
        self.uid = uid
        self.email = email
        self.songUid = songUid
        self.locationUid = locationUid
        self.latitude = latitude
        self.longitude = longitude
        self.isAppleMusicSubscriber = isAppleMusicSubscriber
        self.isAnonymous = isAnonymous
        
        if let title = value[SongKey.title] as? String,
            let artist = value[SongKey.artist] as? String,
            let uid = value[SongKey.uid] as? String,
            let spotifyUri = value[SongKey.spotifyUri] as? String,
            let isSavedToSpotify = value[SongKey.isSavedToSpotify] as? Bool,
            let isPaused = value[SongKey.isPaused] as? Bool,
            let playbackDuration = value[SongKey.playbackDuration] as? Double {
            
            let song = Song(uid: uid, title: title, artist: artist, spotifyUri: spotifyUri, isSavedToSpotify: isSavedToSpotify, isPaused: isPaused, playbackDuration: playbackDuration)
            
            self.song = song
        } else {
            let emptySong = Song()
            self.song = emptySong
        }
        
    }
}

