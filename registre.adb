with identite; use identite;
with Ada.Unchecked_Deallocation;

package body registre is

    procedure Free is
            new Ada.Unchecked_Deallocation (T_Cellule_Registre, T_Registre);

    procedure Initialiser (Registre : out T_Registre) is
    begin
        Registre := Null;
    end;

    function Est_Vide (Registre : in T_Registre) return Boolean is
    begin
        return Registre = Null;
    end;

    function Taille (Registre : in T_Registre) return Integer is
    begin
        if Registre = Null then
            return 0;
        else
            return 1+ Taille(Registre.all.Suivant);
        end if;
    end;

    function Est_Present (Registre : in T_Registre; identifiant : in T_identifiant) return Boolean is
    begin
        if Registre = Null then
            return False;
        elsif identifiant = Registre.all.identifiant then
            return True;
        else
            return Est_Present (Registre.all.Suivant, identifiant);
        end if;
    end;

    procedure Modifier (Registre : in out T_Registre; identifiant : in T_identifiant; nouvelle_carte_identite : in T_id) is
    begin
        if Registre = Null then
            raise Identifiant_Absent_Registre_Exception;
        elsif Registre.all.identifiant = identifiant then
            Registre.all.carte_identite := nouvelle_carte_identite;
        else
            Modifier(Registre.all.Suivant , identifiant , nouvelle_carte_identite);
        end if;
    end;

    procedure Ajouter (Registre : in out T_Registre; identifiant : in T_identifiant; carte_identite : in T_id) is
        Nouvelle_Cellule : T_Registre;
    begin
        if not Est_Present (Registre , identifiant) then
            Nouvelle_Cellule := new T_Cellule_Registre'(identifiant,carte_identite,Registre);
            Registre := Nouvelle_Cellule;
        else
            raise Identifiant_Present_Registre_Exception;
        end if;
    end;

    procedure Afficher_registre (Registre : in T_Registre) is
    begin
        if Registre /= Null then
            Afficher_identifiant(Registre.all.identifiant);
            Afficher_registre (Registre.all.Suivant);
        else
            null;
        end if;
    end;

    procedure Supprimer (Registre : in out T_Registre; identifiant : in T_identifiant) is
    begin
        if not Est_Present (Registre , identifiant) then
            raise Identifiant_Absent_Registre_Exception;
        elsif Registre.all.identifiant = identifiant then
            Registre := Registre.all.Suivant;
        else
            Supprimer (Registre.all.Suivant, identifiant);
        end if;
    end;

    procedure Detruire (Registre : in out T_Registre) is
    begin
        if Registre /= Null then
            Detruire (Registre.all.Suivant);
            Free (Registre);
        else
            null;
        end if;
    end;

end registre;
