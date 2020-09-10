with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;
-- Implantation du module Identite

package body identite is
    
    procedure Free is
            new Ada.Unchecked_Deallocation (T_Cellule_Identite, T_identite);

    procedure Initialiser (carte_identite : out T_identite) is
    begin 
        carte_identite := Null;
    end Initialiser;
    
    function Est_Vide (carte_identite : in T_identite) return Boolean is
    begin
        return carte_identite = Null;
    end Est_Vide;
    
    function Est_present (carte_identite : in T_identite; cle : in String) return Boolean is
    begin
        if carte_identite = Null then
            return False;
        elsif cle = carte_identite.all.cle then
            return True;
        else
            return Est_Present (carte_identite.all.Suivant, cle);
        end if;
    end Est_present;
    
    procedure Ajouter (carte_identite : in out T_identite; new_Cle : in String; new_Info : in String) is
    Nouvelle_Cellule : T_identite;
    begin
        if not Est_Present (carte_identite , new_Cle) then
            Nouvelle_Cellule := new T_Cellule_Identite'(new_Cle,new_Info,carte_identite);
            carte_identite := Nouvelle_Cellule;
        else
            null;
        end if;
    end Ajouter;
    
    procedure Modifier (carte_identite : in  out T_identite; Cle : String; new_Info : in String) is
    begin
        if carte_identite.all.Cle = Cle then
            carte_identite.all.information := new_Info;
        else
            Modifier(carte_identite.all.Suivant , Cle , new_Info);
        end if;
    end Modifier;
    
    function Taille (carte_identite : in T_identite) return Integer is
    begin
        if carte_identite = Null then
            return 0;
        else
            return 1+ Taille(carte_identite.all.Suivant);
        end if;
    end Taille;
    
    procedure Afficher_identite (carte_identite : in T_identite) is
    begin
        if carte_identite /= Null then
            Put(carte_identite.cle); Put(" : "); Put(carte_identite.information); New_Line;
            Afficher_identite(carte_identite.all.Suivant);
        else
            null;
        end if;
    end Afficher_identite;
    
    procedure Supprimer (carte_identite : in out T_identite; Cle : String) is
    begin
        if carte_identite.all.cle = Cle then
            carte_identite := carte_identite.all.Suivant;
        else
            Supprimer (carte_identite.all.Suivant, Cle);
        end if;
    end Supprimer;
    
    procedure Detruire (carte_identite : in out T_identite) is
    begin
        if carte_identite /= Null then
            Detruire (carte_identite.all.Suivant);
            Free (carte_identite);
        else
            null;
        end if;
    end Detruire;
    
end identite;
