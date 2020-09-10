-- Implantation du module Arbre Genealogique

package body Arbre_Genealogique is
    
    procedure Initialiser (Arbre : out T_AG; identifiant : in T_identifiant) is
    begin
        Ajouter_racine (Arbre , identifiant);
    end Initialiser;

    procedure Ajouter_pere (Arbre : in out T_AG; identifiant : in T_identifiant; identifiant_pere : in T_identifiant) is
    begin
        Ajouter_gauche (Arbre , identifiant , identifiant_pere);
    exception
        when Arbre_Gauche_Present_Exception => raise Pere_Present_Exception;
        when Cle_Absente_Exception => raise Identifiant_Absent_Exception;
        when Cle_Presente_Exception => raise Identifiant_Present_Exception;
    end Ajouter_pere;

    procedure Ajouter_mere (Arbre : in out T_AG; identifiant : in T_identifiant; identifiant_mere : in T_identifiant) is
    begin
        Ajouter_droite (Arbre , identifiant , identifiant_mere);
    exception
        when Arbre_Droit_Present_Exception => raise Mere_Present_Exception;
        when Cle_Presente_Exception => raise Identifiant_Present_Exception;
        when Cle_Absente_Exception => raise Identifiant_Absent_Exception;
    end Ajouter_mere;
    
    function Nombre_ancetre (Arbre : in T_AG; identifiant : in T_identifiant) return Integer is
    begin
        return Taille(Arbre, identifiant);
    exception
        when Cle_Absente_Exception => raise Identifiant_Absent_Exception;
    end Nombre_ancetre;
    
    procedure Ancetres (Arbre : in T_AG; identifiant : in T_identifiant; generation : in Integer) is
    begin
        Descendants (Arbre, identifiant, generation);
    exception
        when Etage_Introuvable_Exception => raise Generation_Introuvable_Exception;
        when Cle_Absente_Exception => raise Identifiant_Absent_Exception;
    end Ancetres;
    
    procedure Afficher (Arbre : in T_AG; identifiant : in T_identifiant) is
    begin 
        Afficher_arbre (Arbre, identifiant);
    exception
        when Cle_Absente_Exception => raise Identifiant_Absent_Exception;
    end Afficher;
    
    procedure Supprimer (Arbre : in out T_AG; identifiant : in T_identifiant) is
    begin
        Supprimer_arbre (Arbre , identifiant);
    exception
        when Cle_Absente_Exception => raise Identifiant_Absent_Exception;
    end Supprimer;
        
    procedure un_parent_connu (Arbre : in T_AG) is
    begin 
        un_descendant_connu(Arbre);
    end un_parent_connu;
    
    procedure deux_parents_connus (Arbre : in T_AG) is
    begin
        deux_descendants_connus(Arbre);
    end deux_parents_connus;

    procedure aucun_parent_connu (Arbre : in T_AG) is
    begin
        aucun_descendant_connu(Arbre);
    end aucun_parent_connu;
    
    procedure Ancetres_generation_n (Arbre : in T_AG; identifiant : in T_identifiant; n : Integer) is
    begin
        Descendants_etage_n(Arbre, identifiant, n);
    exception
        when Etage_Introuvable_Exception => raise Generation_Introuvable_Exception;
        when Cle_Absente_Exception => raise Identifiant_Absent_Exception;
    end Ancetres_generation_n;

end Arbre_Genealogique;
