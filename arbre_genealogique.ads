--Specification du module Arbre Genealogique

with arbre_binaire;

generic

    type T_identifiant is private;

    with procedure Afficher_identifiant (identifiant : in T_identifiant);

package Arbre_Genealogique is

    Identifiant_Absent_Exception : Exception;   -- Si un identifiant est absent

    Identifiant_Present_Exception : Exception;  -- Si un identifiant est déjà présent

    Mere_Present_Exception : Exception;  -- Si la mère est déjà présente

    Pere_Present_Exception : Exception; -- Si le père est déjà present

    Generation_Introuvable_Exception : Exception; -- Si la génération est plus grande que la hauteur de l'arbre

    type T_AG is private;

    -- Initialiser un arbre genealogique.  L'arbre contient la racine.
    procedure Initialiser (Arbre : out T_AG; identifiant : in T_identifiant);


    -- Ajouter le père d'un individu donné.
    procedure Ajouter_pere (Arbre : in out T_AG; identifiant : in T_identifiant; identifiant_pere : in T_identifiant);


    -- Ajouter la mère d'un individu donné.
    procedure Ajouter_mere (Arbre : in out T_AG; identifiant : in T_identifiant; identifiant_mere : in T_identifiant);


    -- Déterminer le nombre d'ancêtres d'un individu donnée
    function Nombre_ancetre (Arbre : in T_AG; identifiant : in T_identifiant) return Integer;


    -- Determiner les ancêtres situés à une certaine géneration d'un individu donné
    procedure Ancetres (Arbre : in T_AG; identifiant : in T_identifiant; generation : in Integer);


    -- Afficher l'arbre à partir d'un individu donné
    procedure Afficher (Arbre : in T_AG; identifiant : in T_identifiant);


    -- Supprimer un élement et ses ancêtres de l'arbre
    procedure Supprimer (Arbre : in out T_AG; identifiant : in T_identifiant);


    -- Determiner les individus qui n'ont qu'un parent connu
    procedure un_parent_connu (Arbre : in T_AG);


    -- Determiner les individus qui ont les deux parents connus
    procedure deux_parents_connus (Arbre : in T_AG);


    -- Determiner les individus qui n'ont aucun parent connu
    procedure aucun_parent_connu (Arbre : in T_AG);


    -- Determiner les ancêtres à n génerations pour un individu donnée
    procedure Ancetres_generation_n (Arbre : in T_AG; identifiant : in T_identifiant; n : in Integer);

private

    package New_Arbre_Binaire is new arbre_binaire (T_identifiant, Afficher_identifiant);
    use New_Arbre_Binaire;

    type T_AG is new T_arbre;


end Arbre_Genealogique;
