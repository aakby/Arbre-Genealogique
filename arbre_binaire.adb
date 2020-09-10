with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

-- Implantation du module Arbre binaire

package body arbre_binaire is
    
    procedure Free is
            new Ada.Unchecked_Deallocation (T_Cellule_Arbre, T_arbre);
    
    procedure Initialiser (Arbre : out T_arbre) is
    begin
        Arbre := Null;
    end Initialiser;
    
    function Est_Vide (Arbre : in T_arbre) return Boolean is
    begin 
        return Arbre = Null;
    end Est_Vide;
    
    procedure Ajouter_racine (Arbre : in out T_arbre; cle : in T_cle) is
        arb : T_arbre;
    begin
        Arb := new T_Cellule_Arbre'(cle,null,null);
        Arbre := arb;
    end Ajouter_racine;
        
    procedure Ajouter_droite (Arbre : in out T_arbre; cle : in T_cle; cle_droite : in T_cle) is
    begin
        if Est_present(Arbre,cle_droite) then
            raise cle_Presente_Exception;
        elsif Arbre.all.cle = cle then
            if Arbre.all.Droit /= null then
                raise Arbre_Droit_Present_Exception;
            else
                Ajouter_racine(Arbre.all.Droit, cle_droite); 
            end if;
        elsif Est_present(Arbre.all.Droit,cle) then
            Ajouter_droite(Arbre.all.Droit,cle,cle_droite);
        elsif Est_present(Arbre.all.Gauche,cle) then
            ajouter_droite(Arbre.all.Gauche,cle,cle_droite);
        else
            raise cle_Absente_Exception;
        end if;
    end Ajouter_droite;
    
    procedure Ajouter_gauche (Arbre : in out T_arbre; cle : in T_cle; cle_gauche : in T_cle) is
    begin
        if Est_present(Arbre,cle_gauche) then
            raise cle_Presente_Exception;
        elsif Arbre.all.cle = cle then
            if Arbre.all.Gauche /= null then
                raise Arbre_Gauche_Present_Exception;
            else
                Ajouter_racine(Arbre.all.Gauche, cle_gauche); 
            end if;
        elsif Est_present(Arbre.all.Droit,cle) then
            Ajouter_gauche(Arbre.all.Droit,cle,cle_gauche);
        elsif Est_present(Arbre.all.Gauche,cle) then
            ajouter_gauche(Arbre.all.Gauche,cle,cle_gauche);
        else
            raise cle_Absente_Exception;
        end if;  
    end Ajouter_gauche;

    procedure Supprimer_arbre (Arbre : in out T_arbre; cle : in T_cle) is
    begin
        if Est_present(Arbre, cle) then
            if arbre.all.cle = cle then
                Detruire_arbre(Arbre);
            elsif Est_present(Arbre.all.Droit,cle) then
                Supprimer_arbre(Arbre.all.Droit,cle);
            else
                Supprimer_arbre(Arbre.all.Gauche,cle);
            end if;
        else
            raise cle_Absente_Exception;
        end if;
    end Supprimer_arbre;
    
    function Est_present (Arbre : in T_arbre; cle : in T_cle) return Boolean is
    begin
        if Arbre = null then
            return False;
        elsif (Arbre.all.cle = cle) then
            return True;
        else
            return (Est_present(Arbre.all.Droit, cle)) or (Est_present(Arbre.all.Gauche, cle));
        end if;
    end Est_present;
    
    function Hauteur_totale (Arbre : in T_arbre) return Integer is
    begin
        if Arbre = Null then
            return 0;
        elsif Hauteur_totale (Arbre.all.Droit)<Hauteur_totale (Arbre.all.Gauche) then
            return 1 + Hauteur_totale (Arbre.all.Gauche);
        else
            return 1 + Hauteur_totale (Arbre.all.Gauche);
        end if;
    end Hauteur_totale;
    
    function Hauteur (Arbre : in T_arbre; cle : in T_cle) return Integer is
    begin
        if Arbre = Null then
            return 0;
        elsif Est_present(Arbre.all.Droit,cle) then
            return Hauteur(Arbre.all.Droit, cle);
        elsif Est_present(Arbre.all.Gauche,cle) then
            return Hauteur(Arbre.all.Gauche, cle);
        elsif Arbre.all.Cle = cle then
            return Hauteur_totale(Arbre);
        else
            raise Cle_Absente_Exception;
        end if;
    end Hauteur;
    

    function Taille_totale (Arbre : in T_arbre) return Integer is
    begin
        if Arbre = Null then
            return 0;
        elsif Arbre.all.Droit = Null and Arbre.all.Gauche /= Null then
            return 1 + Taille_totale (Arbre.all.Gauche);
        elsif Arbre.all.Gauche = Null and Arbre.all.Droit /= Null then
            return 1 + Taille_totale (Arbre.all.Droit);
        elsif Arbre.all.Gauche = Null and Arbre.all.Droit /= Null then
            return 0;
        else
            return 1 + Taille_totale (Arbre.all.Gauche) + Taille_totale (Arbre.all.Droit);
        end if;
    end Taille_totale;
        
    function Taille (Arbre : in T_arbre; cle : T_cle) return Integer is
    begin
        if Arbre = Null then
            return 0;
        elsif Est_present (Arbre.all.Droit, cle) then
            return Taille(Arbre.all.Droit, cle);
        elsif Est_present (Arbre.all.Gauche, cle) then
            return Taille(Arbre.all.Gauche, cle);
        elsif Arbre.all.Cle = cle then 
            return Taille_totale(Arbre);
        else
            raise Cle_Absente_Exception;
        end if;
    end Taille;
    
    
    procedure Descendants (Arbre : in T_arbre; cle : in T_cle; etage : in Integer) is
    begin
        if etage > Hauteur_totale (Arbre) then
            raise Etage_Introuvable_Exception;
        elsif etage >= 0 then
            Afficher_cle(Arbre.all.cle); Put("   ");
        end if;
        if Arbre.all.cle = cle then 
            if Arbre.all.Droit /= Null and then etage /= 0 then
                Descendants (Arbre.all.Droit , Arbre.all.Droit.all.cle , etage-1);
            else
                null;
            end if;
            if Arbre.all.Gauche /= Null and then etage /= 0 then
                Descendants (Arbre.all.Gauche , Arbre.all.Gauche.all.cle , etage-1);
            else
                null;
            end if;
        elsif Est_present (Arbre.all.Droit , cle) then
            Descendants (Arbre.all.Droit , cle , etage);
        elsif Est_present (Arbre.all.Gauche , cle) then
            Descendants (Arbre.all.Gauche , cle , etage);
        else
            raise Cle_Absente_Exception;
        end if;
    end Descendants;
    

    procedure un_descendant_connu (Arbre : in T_arbre) is
    begin 
        if Arbre.all.Gauche = Null and Arbre.all.Droit /= Null then
            Afficher_cle(Arbre.all.cle); Put("   ");
            un_descendant_connu(Arbre.all.Droit);
        elsif Arbre.all.Gauche /= Null and Arbre.all.Droit = Null then
            Afficher_cle(Arbre.cle); Put("   ");
            un_descendant_connu(Arbre.all.Gauche);
        elsif Arbre.all.Gauche /= Null and Arbre.all.Droit /= Null then
            un_descendant_connu(Arbre.all.Gauche);
            un_descendant_connu(Arbre.all.Droit);
        else
            null;
        end if;
    end un_descendant_connu;
    
    
    procedure deux_descendants_connus (Arbre : in T_arbre) is
    begin
        if Arbre.all.Gauche = Null and Arbre.all.Droit /= Null then
            deux_descendants_connus(Arbre.all.Droit);
        elsif Arbre.all.Gauche /= Null and Arbre.all.Droit = Null then
            deux_descendants_connus(Arbre.all.Gauche);
        elsif Arbre.all.Gauche /= Null and Arbre.all.Droit /= Null then
            Afficher_cle(Arbre.all.cle); Put("   ");
            deux_descendants_connus(Arbre.all.Droit);
            deux_descendants_connus(Arbre.all.Gauche);
        else
            null;
        end if;
    end deux_descendants_connus;

    
    procedure aucun_descendant_connu (Arbre : in T_arbre) is
    begin
        if Arbre.all.Gauche = Null and Arbre.all.Droit /= Null then
            aucun_descendant_connu(Arbre.all.Droit);
        elsif Arbre.all.Gauche /= Null and Arbre.all.Droit = Null then
            aucun_descendant_connu(Arbre.all.Gauche);
        elsif Arbre.all.Gauche /= Null and Arbre.all.Droit /= Null then
            aucun_descendant_connu(Arbre.all.Droit);
            aucun_descendant_connu(Arbre.all.Gauche);
        elsif Arbre.all.Gauche = Null and Arbre.all.Droit = Null then
            Afficher_cle(Arbre.cle); Put("   ");
        else
            null;
        end if;
    end aucun_descendant_connu;
    
    
    procedure Descendants_etage_n (Arbre : in T_arbre; cle : in T_cle; n : in Integer) is
    begin
        if n > Hauteur_totale (Arbre) then
            raise Etage_Introuvable_Exception;
        elsif n = 0 then
            Afficher_cle(Arbre.all.cle); Put("   ");
        end if;
        if Arbre.all.cle = cle then 
            if Arbre.all.Droit /= Null and then n/=0 then
                Descendants_etage_n (Arbre.all.Droit , Arbre.all.Droit.all.cle , n-1);
            else
                null;
            end if;
            if Arbre.all.Gauche /= Null and then n/=0 then
                Descendants_etage_n (Arbre.all.Gauche , Arbre.all.Gauche.all.cle , n-1);
            else
                null;
            end if;
        elsif Est_present (Arbre.all.Droit , cle) then
            Descendants_etage_n (Arbre.all.Droit , cle , n);
        elsif Est_present (Arbre.all.Gauche , cle) then
            Descendants_etage_n (Arbre.all.Gauche , cle , n);
        else
            raise Cle_Absente_Exception;
        end if;
    end Descendants_etage_n;
    
    
    procedure Afficher (Arbre : in T_arbre) is 
    
        procedure Indenter(Decalage : in Integer) is
        begin
            for I in 1..Decalage loop
                Put (' ');
            end loop;
        end Indenter;

        -- Afficher un arbre à la profondeur Profondeur et qui à du côté
        -- indiqué (< pour Gauche et > pour droit, - pour la racine).
        procedure Afficher_Profondeur (Abr : in T_arbre ; Profondeur : in Integer ; Cote : in Character) is
        begin
            if Abr = Null then
                Null;
            else
                Indenter (Profondeur * 4);
                Put (Cote & ' ');
                Afficher_cle (Abr.all.Cle);
                New_Line;

                Afficher_Profondeur (Abr.all.Gauche, Profondeur + 1, '<');
                Afficher_Profondeur (Abr.all.Droit, Profondeur + 1, '>');
            end if;
        end Afficher_Profondeur;

    begin
        Afficher_Profondeur (Arbre, 0, '-');
    end Afficher;

    procedure Afficher_arbre (Arbre : in T_arbre; cle : in T_cle) is
    begin
        if Arbre.all.Cle = cle then
            Afficher(Arbre);
        elsif Est_present(Arbre.all.Droit, cle) then
            Afficher_arbre (Arbre.all.Droit, cle);
        elsif Est_present(Arbre.all.Gauche, cle) then
            Afficher_arbre (Arbre.all.Gauche, cle);
        else
            null;
        end if;
    end Afficher_arbre;
    
    
    procedure Detruire_arbre (Arbre : in out T_arbre) is
    begin
        if Arbre = Null then
            Null;
        else
            Detruire_arbre (Arbre.all.Gauche);
            Detruire_arbre (Arbre.all.Droit);
            Free (Arbre);
        end if;
    end Detruire_arbre;
    
end arbre_binaire;
