//
//  ContentView.swift
//  Examen
//
//  Created by CCDM28 on 17/11/22.
//

import SwiftUI


    struct ContentView: View {
        let coreDM: CoreDataManager
        @State var codigo = ""
        @State var nombre = ""
        @State var apellido = ""
        @State var username = ""
        @State var rolid = ""
        @State var activo = ""
        @State var newcodigo = ""
        @State var newnombre = ""
        @State var newapellido = ""
        @State var newusername = ""
        @State var newrolid = ""
        @State var newactivo = ""
        @State var seleccionado: Usuario?
        @State var usuArray = [Usuario]()
        
        @State var codigomod = ""
        @State var nombremod = ""
        @State var apellidomod = ""
        @State var usernamemod = ""
        @State var rolidmod = ""
        @State var activomod = ""
        @State var isTapped = false
        
var body: some View {
        NavigationView{
            VStack{
                Text("USUARIOS")
                    .font(.largeTitle)
                    .bold()
                NavigationLink(destination: VStack{
                    TextField("codigo", text: self.$newcodigo).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Nombre", text: self.$newnombre).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Apellido", text: self.$newapellido).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Username", text: self.$newusername).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Rol", text: self.$newrolid).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Activo", text: self.$newactivo).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Guardar")
                    {
                        
                        coreDM.guardarUsuario(codigo: newcodigo, nombre: newnombre, apellido: newapellido, username: newusername, rolid: newrolid, activo: newactivo)
                        newcodigo = ""
                        newnombre = ""
                        newapellido = ""
                        newusername = ""
                        newrolid = ""
                        newactivo = ""
                        mostrarUsuarios()
                    }
                    .background(Color.blue)
                    .foregroundColor(Color.black)
                    }){
                        Text("Agregar").foregroundColor(Color.black).background(Color.blue)
                }

                List{
                    ForEach(usuArray, id: \.self){
                        usu in
                        VStack{
                            Color.blue
                            .edgesIgnoringSafeArea(.all)
                            Text(usu.codigo ?? "")
                            Text(usu.nombre ?? "")
                            Text(usu.apellido ?? "")
                            Color.blue
                            .edgesIgnoringSafeArea(.all)
                        }
                        .onTapGesture{
                            seleccionado = usu
                            codigomod = usu.codigo ?? ""
                            nombremod = usu.nombre ?? ""
                            apellidomod = usu.apellido ?? ""
                            usernamemod = usu.username ?? ""
                            rolidmod = usu.rolid ?? ""
                            activomod = usu.activo ?? ""
                            isTapped.toggle()
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
                NavigationLink("",destination: VStack{
                    TextField("codigo", text: self.$codigomod).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Nombre", text: self.$nombremod).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Apellido", text: self.$apellidomod).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Username", text: self.$usernamemod).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Rol", text: self.$rolidmod).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Activo", text: self.$activomod).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Actualizar"){
                        seleccionado?.codigo = codigomod
                        seleccionado?.nombre = nombremod
                        seleccionado?.apellido = apellidomod
                        seleccionado?.username = usernamemod
                        seleccionado?.rolid = rolidmod
                        seleccionado?.activo = activomod
                    coreDM.actualizarUsuario(usuario: seleccionado!)
codigomod = ""
nombremod = ""
apellidomod = ""
usernamemod = ""
rolidmod = ""
activomod = ""
mostrarUsuarios()
}
.background(Color.blue)
.foregroundColor(Color.black)
}, isActive: $isTapped)
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
