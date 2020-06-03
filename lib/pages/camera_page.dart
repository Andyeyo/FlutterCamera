
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  
  final formKey   = GlobalKey<FormState>();
  bool _guardando = false;
  
  File foto;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual), 
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt), 
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearBoton(),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: 'Nombre',
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre'
      ),
      validator: ( value ) {
        if ( value.length > 3 )
          return 'Ingrese nombre';
        else
          return null;
      },
    );
  }

  Widget _crearBoton(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: ( _guardando ) ? null : _submit ,
    );
  }

  void _submit() {
    if ( ! formKey.currentState.validate() ) return ;

    formKey.currentState.save();

    setState(() { _guardando = true; });

  }

  Widget _mostrarFoto(){
    if (foto == null)
      return  Image(
        image: AssetImage('assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover
      );
    else 
      return Image.file(foto, height: 300.0, fit: BoxFit.cover);
  }

  _seleccionarFoto () async{
    _procesarImagen(ImageSource.gallery);

  }
  
  _tomarFoto() async{
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen( ImageSource origen ) async {
    
    
    final pickedFile = await _picker.getImage(source: origen);

    setState(() {
      foto = File(pickedFile.path);
    });

  }

}