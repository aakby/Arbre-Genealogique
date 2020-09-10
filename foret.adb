with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

-- Implantation du module Foret

package body Foret is
    
    procedure Free_Ensemble_Arbre is
            new Ada.Unchecked_Deallocation (T_Cellule_Ensemble_Arbre, T_Ensemble_Arbre);
    
    procedure Free_Ensemble_Conjoint is
            new Ada.Unchecked_Deallocation (T_Cellule_Conjoints, T_Conjoints);

    procedure Initialiser (Foret : out T_Foret) is
    begin
        Foret.Ensemble_Arbre := Null;
        Foret.Ensemble_Conjoint := Null;
    end Initialiser;

    function Est_Vide (Foret : in T_Foret) return Boolean is
    begin
        return Foret.Ensemble_Arbre = Null;
    end Est_Vide;

    function Sont_Conjoints (Ensemble_Conjoints : in T_Conjoints ; conjoint_1 : T_identifiant ; conjoint_2 : T_identifiant) return Boolean is
    begin
        if Ensemble_Conjoints = Null then
            return False;
        elsif Ensemble_Conjoints.Conjoint_1 = conjoint_1 and Ensemble_Conjoints.Conjoint_2 = conjoint_2 then
            return True;
        else
            return Sont_Conjoints (Ensemble_Conjoints.Suivant , conjoint_1 , conjoint_2 );
        end if;
    end Sont_Conjoints;

    procedure Ajouter_Conjoints (Ensemble_Conjoints : in out T_Conjoints ; conjoint_1 : T_identifiant ; conjoint_2 : T_identifiant) is
        New_Ensemble_Conjoints : T_Conjoints;
    begin
        if not Sont_Conjoints (Ensemble_Conjoints , conjoint_1 , conjoint_2) then
            New_Ensemble_Conjoints := new T_Cellule_Conjoints'(conjoint_1,conjoint_2,Ensemble_Conjoints);
        else 
            raise Conjoints_Present_Exception;
        end if;
    end Ajouter_Conjoints;

    function Nombre_Couples (Ensemble_Conjoints : in T_Conjoints) return Integer is
    begin
        if Ensemble_Conjoints = Null then
            return 0;
        else
            return 1 + Nombre_Couples (Ensemble_Conjoints.Suivant);
        end if;
    end Nombre_Couples;

    procedure Conjoints (Ensemble_Conjoints : in T_Conjoints ; id : in T_identifiant ; Conjoints_id : out T_Conjoints) is
    begin
        if Ensemble_Conjoints /= Null then
            if Ensemble_Conjoints.Conjoint_1 = id then
                Ajouter_Conjoints (Conjoints_id , id , Ensemble_Conjoints.Conjoint_2);
                Conjoints (Ensemble_Conjoints.Suivant , id , Conjoints_id);
            else
                Conjoints (Ensemble_Conjoints.Suivant , id , Conjoints_id);
            end if;
        else
            null;
        end if;
    end Conjoints;

    procedure Demi_freres_soeurs (Foret : in T_Foret ; identifiant : T_identifiant) is
    begin
        null;
    end Demi_freres_soeurs;

    procedure Detruire_Ensemble_Arbre (Ensemble_Arbre : in out T_Ensemble_Arbre) is
    begin
        if Ensemble_Arbre = Null then
            Null;
        else
            Detruire_Ensemble_Arbre (Ensemble_Arbre.Suivant);
            Free_Ensemble_Arbre (Ensemble_Arbre);
        end if;
    end Detruire_Ensemble_Arbre;

    procedure Detruire_Ensemble_Conjoint (Ensemble_Conjoint : in out T_Conjoints) is
    begin
        if Ensemble_Conjoint = Null then
            Null;
        else
            Detruire_Ensemble_Conjoint (Ensemble_Conjoint.Suivant);
            Free_Ensemble_Conjoint (Ensemble_Conjoint);
        end if;
    end Detruire_Ensemble_Conjoint;

    procedure Detruire (Foret : in out T_Foret) is
    begin
        Detruire_Ensemble_Arbre (Foret.Ensemble_Arbre);
        Detruire_Ensemble_Conjoint (Foret.Ensemble_Conjoint);
    end Detruire;

end Foret;
