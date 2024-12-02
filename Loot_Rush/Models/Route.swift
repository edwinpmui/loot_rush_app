import CoreLocation

struct Route: Identifiable {
    let id = UUID()
    let name: String
    let waypoints: [CLLocationCoordinate2D]
}
