class MarkerManager{
  constructor(map){
    this.map = map;
    this.markers = [];
  }

  _benchestoAdd(benches){
    return benches.filter(bench => (
      !this.markers.some(marker => (
        marker.position.lat() === bench.lat && marker.position.lng() === bench.lng
      ))
    ));
  }

  _markerstoRemove(benches){
    return this.markers.filter(marker => (
      benches.some(bench => {
        return marker.position.lat() === bench.lat && marker.position.lng() === bench.lng;
      })
    ));
  }

  _removeMarker(marker){
    marker.setMap(null);
  }

  _createMarkerFromBench(bench){
    let marker = new google.maps.Marker({
      map: this.map,
      position: new google.maps.LatLng(bench.lat, bench.lng),
      title: bench.description
    });

    this.markers.push(marker);
    marker.setMap(this.map);
  }

  updateMarkers(benches){
    this.markers = [];
    this._markerstoRemove(benches).forEach(marker => {
      this._removeMarker(marker);
    });
    this._benchestoAdd(benches).forEach(bench => {
      this._createMarkerFromBench(bench);
    });
    console.log(this.markers);
  }
}

export default MarkerManager;
