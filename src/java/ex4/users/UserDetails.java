/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ex4.users;

import ex4.db.DataBase;

/**
 *
 * @author tieboss
 */

public class UserDetails {
    
    private DataBase db = new DataBase();
    private boolean dbStatus = false;
    
    public UserDetails () {
        db = new DataBase();
        dbStatus = db.open();
    }

    
    
    public boolean registerUser(String firstName, String lastName, String login, String password, String email){
    
        if(dbStatus){
            boolean exist = db.checkIfExist(firstName, lastName, login, password, email);
            if(!exist){
                db.save(firstName, lastName, login, password, email);
                return true;
            }
        }
        return false;
    }
    
    public boolean login(String login, String password){
    
        if(dbStatus){
            return db.checkUsernameAndPassword(login, password);
        }
        return false;
    }
}
