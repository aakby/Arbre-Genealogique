-- Specification du module Arbre binaire

generic
    
    type T_cle is private;	-- Type des identifiants de l'arbre
    
    with procedure Afficher_cle (cle : in T_cle);   -- Procedure qui affiche les cles
    
package arbre_binaire is
    
    Cle_Absente_Exception : Exception;   -- Si une clé est absente
    
    Cle_Presente_Exception : Exception;  -- Si une clé est déjà présente
    
    Arbre_Droit_Present_Exception : Exception;  -- Si Arbre.Gauche est déjà présent
    
    Arbre_Gauche_Present_Exception : Exception; -- Si Arbre.Droite est déjà present
    
    Etage_Introuvable_Exception : Exception; -- Si l'etage est plus grand que la hauteur de l'arbre
    
    type T_arbre is private;
    
    -- Initialiser une arbre binaire
    procedure Initialiser (Arbre : out T_arbre);
    
    
    -- Verifier si l'arbre est vide ou pas
    function Est_Vide (Arbre : in T_arbre) return Boolean;
    
    
    -- Ajouter la racine à un arbre vide
    procedure Ajouter_racine (Arbre : in out T_arbre; cle : in T_cle);
    
    
    -- Ajouter un élément à droite de l'arbre
    -- Exception : Arbre_Droit_Present_Exception si Arbre.Droit est deja present
    -- Exception : Cle_Presente_Exception si la cle de l'élement à ajouter est déjà present dans l'arbre
    -- Exception : Cle_Absente_Exception si la cle de l'élement est absent de l'arbre
    procedure Ajouter_droite (Arbre : in out T_arbre; cle : in T_cle; cle_droite : in T_cle);
    
    
    -- Ajouter un élément à gauche d'un individu
    -- Exception : Arbre_Gauche_Present_Exception si Arbre.Gauche est deja present
    -- Exception : Cle_Presente_Exception si la cle de l'élement à ajouter est déjà present dans l'arbre
    -- Exception : Cle_Absente_Exception si la cle de l'élement est absent de l'arbre
    procedure Ajouter_gauche (Arbre : in out T_arbre; cle : in T_cle; cle_gauche : in T_cle);

    
    -- Supprimer un élement et ses descendants de l'arbre
    -- Exception : Cle_Absente_Exception si la cle de l'élement à supprimer n'existe pas dans l'arbre
    procedure Supprimer_arbre (Arbre : in out T_arbre; cle : in T_cle);

    
    -- Tester si une cle est présente dans l'arbre
    function Est_present (Arbre : in T_arbre; cle : in T_cle) return Boolean;

    
    -- Determiner la hauteur de l'arbre à partir d'un noeud donné
    -- Exception : Cle_Absente_Exception si la cle du noeud n'exite pas dans l'arbre
    function Hauteur (Arbre : in T_arbre; cle :in T_cle) return Integer;
    
    
    -- Determiner le nombre des élements d'un arbre
    -- Exception : Cle_Absente_Exception si la cle du noeud n'exite pas dans l'arbre
    function Taille (Arbre : in T_arbre; cle : T_cle) return Integer;
    
    
    -- Determiner les descendants d'une clé situés jusqu'un etage
    -- Exception : Etage_Introuvable_Exception si l'etage est plus grand que la hauteur de l'arbre
    -- Exception : Cle_Absente_Exception si la cle du noeud n'exite pas dans l'arbre
    procedure Descendants (Arbre : in T_arbre; cle : in T_cle; etage : in Integer);
    
    
    -- Determiner les elements qui n'ont qu'un parent
    procedure un_descendant_connu (Arbre : in T_arbre);
    
    
    -- Determiner les individus qui ont les deux parents connus
    procedure deux_descendants_connus (Arbre : in T_arbre);


    -- Determiner les individus qui n'ont aucun parent connu
    procedure aucun_descendant_connu (Arbre : in T_arbre);
            
            
    -- Determiner les descendants à la n-ième géneration pour une clé donnée
    -- Exception : Etage_Introuvale_Exception si n > Hauteur (Arbre, cle)
    -- Exception : Cle_Absente_Exception si la clé n'existe pas dans l'arbre
    procedure Descendants_etage_n (Arbre : in T_arbre; cle : in T_cle; n : in Integer);
    
    
    -- Afficher l'arbre à partir d'une clé donné
    -- Exception : Cle_Absente_Exception si la cle n'existe pas dans l'arbre
    procedure Afficher_arbre (Arbre : in T_arbre; cle : T_cle);

    
    -- Detruire un arbre binaire
    -- Il ne doit plus être utilisé sauf à être de nouveau initialisé
    procedure Detruire_arbre (Arbre : in out T_arbre);

private
    
    type T_Cellule_Arbre;
    
    type T_arbre is access T_Cellule_Arbre;
    
    type T_Cellule_Arbre is record
        Cle : T_cle;
        Droit : T_arbre;
        Gauche : T_arbre;
    end record;
    
end arbre_binaire;
