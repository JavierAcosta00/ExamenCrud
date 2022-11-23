//
//  CoreDataManager.swift
//  Examen
//
//  Created by CCDM28 on 17/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persitenContainer : NSPersistentContainer
    
    init(){
        persitenContainer = NSPersistentContainer(name: "Usuario")
        persitenContainer.loadPersistentStores(completionHandler:{
            (description, error) in
            if let error = error {
                fatalError("Core dat failed to initzializee \(error.localizedDescription)")
            }
        })
    }
    
    func guardarUsuario(id: String, nombre: String, apellido: String, username: String, rolid: String, activo: String){
        let usuario = Usuario(context: persitenContainer.viewContext)
        usuario.id = id
        usuario.nombre = nombre
        usuario.apellido = apellido
        usuario.username = username
        usuario.rolid = rolid
        usuario.activo = activo
        
        do{
            try persitenContainer.viewContext.save()
            print("Usuario guardado")
        }catch{
            print("Fallo al guardar en \(error)")
        }
    }
    func leerTodosLosUsuarios() -> [Usuario]{
            let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()

            do{
                return try persitenContainer.viewContext.fetch(fetchRequest)
            }
            catch{
                return []
            }
        }
    
    func borrarUsuario(usuario: Usuario){
        persitenContainer.viewContext.delete(usuario)

         do{
             try persitenContainer.viewContext.save()
         }catch{
             persitenContainer.viewContext.rollback()
             print("Failed to save context")
         }
     }

    func actualizarUsuario(usuario: Usuario){
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", usuario.id ?? "")
        fetchRequest.predicate = predicate

        do{
            let datos = try persitenContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.nombre = usuario.nombre
            p?.apellido = usuario.apellido
            p?.username = usuario.username
            p?.rolid = usuario.rolid
            p?.activo = usuario.activo
            try persitenContainer.viewContext.save()
            print("Usuario guardado")
        }catch{
            print("failed to save error en \(error)")
        }
    }
    
    func leerUsuarios(id: String) -> Usuario?{
         let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
         let predicate = NSPredicate(format: "id = %@", id)
         fetchRequest.predicate = predicate
         do{
             let datos = try persitenContainer.viewContext.fetch(fetchRequest)
             return datos.first
         }catch{
             print("failed to save error en \(error)")
         }
         return nil
     }
}
