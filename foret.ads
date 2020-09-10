with Arbre_Genealogique;

generic

    type T_identifiant is private;
    
    with procedure Afficher_identifiant (identifiant : in T_identifiant);

package Foret is

    Conjoints_Present_Exception : Exception;

    Conjoints_Absent_Exception : Exception;

    type T_Foret is private;
    
    type T_Conjoints is private;

    -- Initialiser une foret vide
    procedure Initialiser (Foret : out T_Foret);

    -- Verifier si une foret est vide ou pas
    function Est_Vide (Foret : in T_Foret) return Boolean;

    -- Verifier si deux individus sont conjoints
    function Sont_Conjoints (Ensemble_Conjoints : in T_Conjoints ; conjoint_1 : in T_identifiant ; conjoint_2 : in T_identifiant) return Boolean;
    
    -- Ajouter deux coinjoints à la foret
    procedure Ajouter_Conjoints (Ensemble_Conjoints : in out T_Conjoints ; conjoint_1 : in T_identifiant ; conjoint_2 : in T_identifiant);

    -- Determiner le nombre de conjoints dans la foret 
    function Nombre_Couples (Ensemble_Conjoints : in T_Conjoints) return Integer;

    -- Determiner l'ensemble des conjoints d'un individu
    procedure Conjoints (Ensemble_Conjoints : in T_Conjoints ; id : in T_identifiant ; Conjoints_id : out T_Conjoints);

    -- Determiner les demi-freres et les demi-soeurs d'un individu
    procedure Demi_freres_soeurs (Foret : in T_Foret ; identifiant : in T_identifiant);

    -- Detruire la foret
    procedure Detruire (Foret : in out T_Foret);   
    
private

    package AG is new Arbre_Genealogique(T_identifiant,Afficher_identifiant);
    use AG;
    
    type T_Cellule_Conjoints;

    type T_Conjoints is access T_Cellule_Conjoints;

    type T_Cellule_Ensemble_Arbre;

    type T_Ensemble_Arbre is access T_Cellule_Ensemble_Arbre;    

    type T_Foret is record
        Ensemble_Arbre : T_Ensemble_Arbre;
        Ensemble_Conjoint : T_Conjoints;
    end record;

    type T_Cellule_Ensemble_Arbre is record
        Arbre : T_AG;
        Suivant : T_Ensemble_Arbre;
    end record;

    type T_Cellule_Conjoints is record
        Conjoint_1 : T_identifiant;
        Conjoint_2 : T_identifiant;
        Suivant : T_Conjoints;        
    end record;
    
end Foret;
