--Specification du module Registre

with identite; use identite;

generic

    type T_identifiant is private;

package Registre is


    type T_Registre is limited private;

    type T_id is new T_identite;

    Identifiant_Absent_Registre_Exception : Exception;

    Identifiant_Present_Registre_Exception : Exception;


    -- Initialiser un registre.  Le registre est vide.
    procedure Initialiser (Registre : out T_Registre);


    -- Vérifier si le registre est vide
    function Est_Vide (Registre : in T_Registre) return Boolean;


    -- Obtenir la taille du registre
    function Taille (Registre : in T_Registre) return Integer;


    -- Verifier si un individu est present dans le registre
    function Est_Present (Registre : in T_Registre; identifiant : in T_identifiant) return Boolean;


    -- Modifier les informations d'identité d'un élement du registre
    -- Exception : Identifiant_Absent_Registre_Exception si l'identifiant de l'élement à modifier n'existe pas dans le registre
    procedure Modifier (Registre : in out T_Registre; identifiant : in T_identifiant; nouvelle_carte_identite : in T_id);


    -- Ajouter un élement au registre
    -- Exception : Identifiant_Present_Registre_Exception si l'identifiant de l'élement à ajouter existe déjà dans le registre
    procedure Ajouter (Registre : in out T_Registre; identifiant : in T_identifiant; carte_identite : in T_id);


    -- Afficher le registre
    generic
        with procedure Afficher_identifiant (identifiant : T_identifiant);
    procedure Afficher_registre (Registre : in T_Registre);


    -- Supprimer un élement de registre
    -- Exception : Identifiant_Absent_Registre_Exception si l'identifiant de l'élement à supprimer n'existe pas dans le registre
    procedure Supprimer (Registre : in out T_Registre; identifiant : in T_identifiant);


    -- Détruire le registre
    -- Il ne doit plus être utilisé sauf à être de nouveau initialisé.
    procedure Detruire (Registre : in out T_Registre);

private

    type T_Cellule_Registre;

    type T_Registre is access T_Cellule_Registre;

    type T_Cellule_Registre is record
        identifiant : T_identifiant;
        carte_identite : T_Id;
        Suivant : T_Registre;
    end record;

end Registre;
