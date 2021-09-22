import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomShadowButton.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:location/location.dart' as ph;




class LocationMapScreen extends StatefulWidget {
  LocationMapScreen({Key key}) : super(key: key);

  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
   GoogleMapController mapController;
  double lat = 0.0;
  double lon = 0.0;
  String address = '';
  LatLng _locationPosition = LatLng(0.0, 0.0);
  final LatLng _center = const LatLng(45.521563, -122.677433);
   Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
   
  }
  @override
  void initState() { 
    super.initState();
     _getCurrentLocation();
  }

   _getCurrentLocation() async {
  ph.Location location = new ph.Location();

  bool _serviceEnabled;
  ph.PermissionStatus _permissionGranted;
  ph.LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    
    if (!_serviceEnabled) {
      return _getCurrentLocation();
    }
  }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == ph.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != ph.PermissionStatus.granted) {
      return;
    }
  }
  _locationData = await location.getLocation();

  lat = _locationData.latitude;
  lon = _locationData.longitude;
  initdata();
 }
  initdata() async{
    _locationPosition = LatLng(lat,
        lon);
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _locationPosition, zoom: 24),
          ),
     );
     _markers.clear();
     _markers.add(Marker(
            markerId: MarkerId('arrival'),
            draggable: true,
            position: _locationPosition,
             infoWindow: InfoWindow(
    title: 'Destination',
    snippet: 'adassad',
  ),
  
            icon: BitmapDescriptor.defaultMarker));
            setState(() {
            });
  }
   
   void _updatePosition(CameraPosition _position) {
     _locationPosition = LatLng(
         _position.target.latitude,
         _position.target.longitude);
         print(_position.target.latitude);
         print(_position.target.longitude);
         getAddfromLatLon(
           lat: _position.target.latitude,
           lon: _position.target.longitude
         );
    _markers.clear();

    setState(() {
     _markers.add(Marker(
            markerId: MarkerId('arrival'),
            draggable: true,
            position: _locationPosition,
             infoWindow: InfoWindow(
    title: 'Destination',
    snippet: 'adassad',
  ),
            icon: BitmapDescriptor.defaultMarker));
    });
  }
  getAddfromLatLon({double lat,double lon}) async {
this.lat = lat;
this.lon = lon;
    try {
       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
     setState(() {
       address = '''${placemarks[0].locality.trim()},${placemarks[0].subLocality.trim()}, ${placemarks[0].subAdministrativeArea.trim()},${placemarks[0].name.trim()}'''.trim();
     print(Global.address);
     });
    } catch (e) {
      //Toast.show(e.toString(), context);
    }
   }
  @override
  Widget build(BuildContext context) {
         SizeConfig().init(context);
     return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: Loader(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: WillPopScope(
             onWillPop: () async => true,
            child: SafeArea(
            child: Scaffold( 
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                //flexibleSpace: AppColors.flexibleAppBar
              ),
              
                 
              body: Container(
                  
                  width: double.infinity,   
                 // height: SizeConfig.screenHeight,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            
                            child: GoogleMap(
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  onCameraMove: (position) => _updatePosition(position),
                   mapType: MapType.normal,
                              markers: _markers,
                             // polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: CameraPosition(
                  target: _locationPosition,
                  zoom: 11.0,
                  ),
                 ),
                          ),
                        ),
                        Container(
                            //height: 100,
                            padding: EdgeInsets.all(8),
                            width: SizeConfig.screenWidth,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('Location',style: AppStyles.greyTextStyle,),
                               Text(address,style: AppStyles.blackTextStyle.copyWith(
                                 fontWeight: FontWeight.w600,fontSize: 18
                               ),),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: CustomShadowButtom(
                                   text: 'CONFIRM THE LOCATION',
                                   onTap: (){
                                     setState(() {
                                       Global.address = address;
                                       Global.lat = lat.toString();
                                       Global.lon = lon.toString();
                                     });
                                     Navigator.pop(context);
                                   },
                                 ),
                               )
                             ],
                            ),
                          )
                      ]))))))

    );
  }
}