import 'package:flutter/material.dart';

class AddContactForm extends StatefulWidget {
  final Function onSubmit;

  AddContactForm({required this.onSubmit});

  @override
  _AddContactFormState createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final TextEditingController appNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController versionNumberController = TextEditingController();
  final TextEditingController supportPhoneNumberController = TextEditingController();
  final TextEditingController releaseDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Solicitud para agregar app', style: Theme.of(context).textTheme.headline6),
            TextFormField(
              controller: appNameController,
              decoration: InputDecoration(labelText: 'Nombre de la app'),
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              controller: versionNumberController,
              decoration: InputDecoration(labelText: 'Número de versión'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: supportPhoneNumberController,
              decoration: InputDecoration(labelText: 'Número de teléfono de soporte'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: releaseDateController,
              decoration: InputDecoration(labelText: 'Fecha de lanzamiento'),
              keyboardType: TextInputType.datetime,
            ),
            ElevatedButton(
              onPressed: () {
                // Verificar que todas las variables estén llenas
                if (appNameController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    versionNumberController.text.isEmpty ||
                    supportPhoneNumberController.text.isEmpty ||
                    releaseDateController.text.isEmpty) {
                  // Mostrar un mensaje de error si alguna variable está vacía
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Llenar correctamente todo el formulario'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Recolectar los datos del formulario y llamar a la función onSubmit
                  widget.onSubmit({
                    'appName': appNameController.text,
                    'description': descriptionController.text,
                    'versionNumber': versionNumberController.text,
                    'supportPhoneNumber': supportPhoneNumberController.text,
                    'releaseDate': releaseDateController.text,
                  });

                  // Limpiar los controladores de texto después de presionar "Aceptar"
                  appNameController.clear();
                  descriptionController.clear();
                  versionNumberController.clear();
                  supportPhoneNumberController.clear();
                  releaseDateController.clear();
                }
              },
              child: Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}