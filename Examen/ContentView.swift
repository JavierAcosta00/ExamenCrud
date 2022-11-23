//
//  ContentView.swift
//  Examen
//
//  Created by CCDM28 on 17/11/22.
//

import SwiftUI


    struct ContentView: View {
        let coreDM: CoreDataManager
        @State var id = ""
        @State var nombre = ""
        @State var apellido = ""
        @State var username = ""
        @State var rolid = ""
        @State var activo = ""
        @State var newid = ""
        @State var newnombre = ""
        @State var newapellido = ""
        @State var newusername = ""
        @State var newrolid = ""
        @State var newactivo = ""
        @State var seleccionado: Usuario?
        @State var usuArray = [Usuario]()
var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: VStack{
                    TextField("ID", text: self.$newid).multilineTextAlignment(.center)
                    TextField("Nombre", text: self.$newnombre).multilineTextAlignment(.center)
                    TextField("Apellido", text: self.$newapellido).multilineTextAlignment(.center)
                    TextField("Username", text: self.$newusername).multilineTextAlignment(.center)
                    TextField("Rol", text: self.$newrolid).multilineTextAlignment(.center)
                    TextField("Activo", text: self.$newactivo).multilineTextAlignment(.center)

                    Button("Guardar"){
                        coreDM.guardarUsuario(id: newid, nombre: newnombre, apellido: newapellido, username: newusername, rolid: newrolid, activo: newactivo)
                        newid = ""
                        newnombre = ""
                        newapellido = ""
                        newusername = ""
                        newrolid = ""
                        newactivo = ""
                        mostrarUsuarios()
                    }
                    }){
                    Text("Agregar")
                }

                List{
                    ForEach(usuArray, id: \.self){
                        usu in
                        VStack{
                            Text(usu.nombre ?? "")
                        }
                        .onTapGesture{
                            seleccionado = usu
                            id = usu.id ?? ""
                        }
                    }.onDelete(perform: {
                        indexSet in
                        indexSet.forEach({ index in
                        let usuario = usuArray[index]
                            coreDM.borrarUsuario(usuario: usuario)
                        mostrarUsuarios()
                        })
                    })
                }.padding()
                    .onAppear(perform: {mostrarUsuarios()})
            }
        }
    }
    func mostrarUsuarios(){
        usuArray = coreDM.leerTodosLosUsuarios()
        }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
