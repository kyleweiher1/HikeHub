//
//  List.swift
//  HikeHub
//
//  Created by Kyle Weiher on 3/2/23.
//
import SwiftUI

struct Trail: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var length: Double
    var difficulty: String
    var description: String
}

struct ListView: View {
    let trails = [
        Trail(name: "Petrifying Springs Trail", location: "Petrifying Springs Park", length: 2.4, difficulty: "Easy", description: "Experience this 2.4-mile loop trail near Kenosha, Wisconsin. Generally considered an easy route, it takes an average of 46 min to complete. This is a very popular area for birding, cross-country skiing, and fishing, so you'll likely encounter other people while exploring. The trail is open year-round and is beautiful to visit anytime. Dogs are welcome, but must be on a leash."),
        Trail(name: "Petrifying Springs Loop", location: "Petrifying Springs Park", length: 10.0, difficulty: "Easy", description: "Enjoy this 2.4-mile loop trail near Kenosha, Wisconsin. Generally considered an easy route, it takes an average of 49 min to complete. This is a popular trail for road biking, running, and walking, but you can still enjoy some solitude during quieter times of day. Dogs are welcome, but must be on a leash."),
        Trail(name: "Hawthorn Hollow Nature Sancuary and Arboretum", location: "Hawthorn Hollow Nature Center", length: 0.7, difficulty: "Easy", description: "Check out this 0.7-mile loop trail near Kenosha, Wisconsin. Generally considered an easy route, it takes an average of 15 min to complete. This is a popular trail for birding, hiking, and walking, but you can still enjoy some solitude during quieter times of day. The trail is open year-round and is beautiful to visit anytime. You'll need to leave pups at home — dogs aren't allowed on this trail."),
        Trail(name: "Parkside Cross Country Trails", location: "Wayne E Dannehl National Cross Country Course", length: 5.4, difficulty: "Moderate",description: "Discover this 5.4-mile loop trail near Kenosha, Wisconsin. Generally considered an easy route, it takes an average of 1 h 47 min to complete. This is a popular trail for cross-country skiing, hiking, and running, but you can still enjoy some solitude during quieter times of day."),
        Trail(name: "Sanders Park Hardwood Trail", location: "Hawthorn Hollow Nature Center", length: 2.1, difficulty: "Easy",description: "Check out this 2.1-mile loop trail near Racine, Wisconsin. Generally considered an easy route, it takes an average of 40 min to complete. This trail is great for birding, camping, and cross-country skiing, and it's unlikely you'll encounter many other people while exploring. The trail is open year-round and is beautiful to visit anytime. You'll need to leave pups at home — dogs aren't allowed on this trail."),
        Trail(name: "Kenosha Dunes Trail", location: "Hawthorn Hollow Nature Center", length: 2.0, difficulty: "Easy",description: "Get to know this 2.0-mile loop trail near Kenosha, Wisconsin. Generally considered an easy route, it takes an average of 36 min to complete. This is a popular trail for birding, fishing, and hiking, but you can still enjoy some solitude during quieter times of day. The trail is open year-round and is beautiful to visit anytime."),
        Trail(name: "Gander Mountain Trail", location: "Gander Mountain Forest Preserve", length: 6.0, difficulty: "Hard",description: "Explore this 1.4-mile loop trail near Spring Grove, Illinois. Generally considered a moderately challenging route. This is a very popular area for birding, cross-country skiing, and hiking, so you'll likely encounter other people while exploring. The trail is open year-round and is beautiful to visit anytime. Dogs are welcome, but must be on a leash.")
    ]

    var body: some View {
        NavigationView {
            List(trails) { trail in
                NavigationLink(destination: TrailDetailsView(trail: trail)) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(trail.name)
                                .font(.headline)
                            Spacer()
                            ForEach(0..<getDifficultyRating(trail.difficulty)) { index in
                                Image(systemName: "diamond.fill")
                                    .foregroundColor(.black)
                            }
                        }
                        Text(trail.location)
                            .font(.subheadline)
                        HStack {
                            Text(String(format: "%.1f", trail.length))
                            Text(trail.difficulty)
                        }
                        .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Saved Trails")
        }
    }
    
    func getDifficultyRating(_ difficulty: String) -> Int {
        switch difficulty {
        case "Easy":
            return 1
        case "Moderate":
            return 2
        case "Hard":
            return 3
        default:
            return 0
        }
    }
}



struct TrailDetailsView: View {
    
    let trail: Trail
    
    var body: some View {
        VStack {
            Text(trail.name)
                .font(.title)
                .bold()
            Text(trail.location)
                .font(.headline)
            HStack {
                Text(String(format: "%.1f miles", trail.length)) // Add "miles" to length
                Spacer()
                Text(trail.difficulty)
            }
            .font(.subheadline)
            .padding(.top, 8)
            
            Text(trail.description) // Display the description of the trail
                .font(.body)
                .padding(.top, 16)
            
            Spacer()
        }
        .padding(16)
        .navigationTitle("") // Remove the navigation title
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
