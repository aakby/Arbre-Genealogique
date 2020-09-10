-- Specification du module Identité

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package identite is

    type T_identite is private;    
    
    -- Initialiser une carte d'identité vide
    procedure Initialiser (carte_identite : out T_identite);
    
    
    -- Verifier si la carte d'identite est vide
    function Est_Vide (carte_identite : in T_identite) return Boolean;
    
    
    --Verifier si une cle est presente dans la carte d'identite
    function Est_present (carte_identite : in T_identite; cle : in String) return Boolean;
    
    
    -- Ajouter à la carte d'identité une nouvelle clé et une nouvelle information
    procedure Ajouter (carte_identite : in out T_identite; new_Cle : in String; new_Info : in String);
    
    
    -- Modifier l'information d'une clé dans la carte d'identité
    procedure Modifier (carte_identite : in  out T_identite; Cle : String; new_Info : in String);
    
    
    -- Determiner la taille de la carte d'identite
    function Taille (carte_identite : in T_identite) return Integer;
    
    
    -- Afficher la carte d'identite
    procedure Afficher_identite (carte_identite : in T_identite);
    
    
    -- Supprimer une cle de la carte d'identite
    procedure Supprimer (carte_identite : in out T_identite; Cle : String);
    
   
    -- Detruire la carte d'identite
    procedure Detruire (carte_identite : in out T_identite);
    
private

    type T_Cellule_Identite;

    type T_identite is access T_Cellule_Identite;

    type T_Cellule_Identite is record
        cle : String(1..10);
        information : String(1..10);
        Suivant : T_identite;
    end record;

end identite;
