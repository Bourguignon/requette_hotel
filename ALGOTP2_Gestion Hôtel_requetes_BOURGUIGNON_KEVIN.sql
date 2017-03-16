--Nombre de clients

select count(*) as NbClient
from T_CLIENT;

--Les clients triés sur le titre et le nom

select T_CLIENT.CLI_ID,CLI_NOM,CLI_PRENOM,TIT_LIBELLE,T_TITRE.TIT_CODE
from T_CLIENT,T_TITRE
where T_CLIENT.TIT_CODE = T_TITRE.TIT_CODE

--Les clients triés sur le libellé du titre et le nom

select T_CLIENT.CLI_ID,CLI_NOM,CLI_PRENOM,TIT_LIBELLE
from T_CLIENT,T_TITRE
where T_CLIENT.TIT_CODE = T_TITRE.TIT_CODE

--Les clients commençant par 'B'

select CLI_ID,CLI_NOM,CLI_PRENOM
from T_CLIENT
where CLI_NOM like "B%";

--Les clients homonymes

select distinct CLI_ID,CLI_NOM,CLI_PRENOM
from T_CLIENT as tbl
where exists (select CLI_NOM,CLI_PRENOM
			  from T_CLIENT as dbl
			  where tbl.CLI_ID<>dbl.CLI_ID
			  and tbl.CLI_NOM = dbl.CLI_NOM);

--Nombre de titres différents

select count(*) as NbTitre
from T_TITRE;

--Nombre d'enseignes

select count(*) as NbEnseigne
from T_CLIENT
where CLI_ENSEIGNE <> "null";

--Les clients qui représentent une enseigne 

select CLI_NOM,CLI_PRENOM
from T_CLIENT
where CLI_ENSEIGNE <> "null";

--Les clients qui représentent une enseigne de transports

select CLI_NOM,CLI_PRENOM
from T_CLIENT
where CLI_ENSEIGNE like "Transport%";

--Nombre d'hommes,Nombres de femmes, de demoiselles, Nombres de sociétés

select count(*) as NbH
from T_CLIENT
where TIT_CODE like "M.";

--Nombre d''emails

select count(*) as NbEmail
from T_EMAIL;

--Client sans email 

select CLI_NOM
from T_CLIENT
where CLI_ID not in(select CLI_ID
					from T_EMAIL);

--Clients sans téléphone 

select CLI_NOM
from T_CLIENT
where CLI_ID not in(select CLI_ID
					from T_TELEPHONE);

--Les phones des clients

select TEL_NUMERO,TYP_CODE,TEL_LOCALISATION,CLI_NOM
from T_TELEPHONE, T_CLIENT
where T_TELEPHONE.CLI_ID = T_CLIENT.CLI_ID;

--Ventilation des phones par catégorie

select TEL_NUMERO,TYP_CODE,TEL_LOCALISATION,CLI_NOM
from T_TELEPHONE, T_CLIENT
where T_TELEPHONE.CLI_ID = T_CLIENT.CLI_ID
order by TYP_CODE;

--Les clients ayant plusieurs téléphones

--Clients sans adresse:

select CLI_NOM
from T_CLIENT
where CLI_ID not in(select CLI_ID
					from T_ADRESSE);

--Clients sans adresse mais au moins avec mail ou phone 

select CLI_NOM
from T_CLIENT
where CLI_ID not in(select CLI_ID
					from T_ADRESSE)
and CLI_ID in(select CLI_ID
					from T_TELEPHONE)
or CLI_ID in(select CLI_ID
					from T_EMAIL);

--Dernier tarif renseigné

select *
from T_TARIF
order by TRF_DATE_DEBUT desc;

--Tarif débutant le plus tôt 

--Différentes Années des tarifs

select *
from T_TARIF
order by TRF_DATE_DEBUT desc;

--Nombre de chambres de l'hotel 

select count(*) as NbChambre
from T_CHAMBRE;

--Nombre de chambres par étage

--Chambres sans telephone

select CHB_NUMERO
from T_CHAMBRE
where CHB_POSTE_TEL = "0";

--Existence d'une chambre n°13 ?

select CHB_NUMERO
from T_CHAMBRE
where CHB_NUMERO like "13";

--Chambres avec sdb

select CHB_NUMERO
from T_CHAMBRE
where CHB_BAIN = "1";

--Chambres avec douche

select CHB_NUMERO
from T_CHAMBRE
where CHB_DOUCHE = "1";

--Chambres avec WC

select CHB_NUMERO
from T_CHAMBRE
where CHB_WC = "1";

--Chambres sans WC séparés

select CHB_NUMERO
from T_CHAMBRE
where CHB_WC = "0";

--Quels sont les étages qui ont des chambres sans WC séparés ?

--Nombre d'équipements sanitaires par chambre trié par ce nombre d'équipement croissant

--Chambres les plus équipées et leur capacité

--Repartition des chambres en fonction du nombre d'équipements et de leur capacité

--Nombre de clients ayant utilisé une chambre

--Clients n'ayant jamais utilisé une chambre (sans facture)

select CLI_NOM
from T_CLIENT
where CLI_ID not in (select CLI_ID 
					 from T_FACTURE);

--Nom et prénom des clients qui ont une facture

select distinct CLI_NOM,CLI_PRENOM
from T_CLIENT
where CLI_ID in (select CLI_ID from T_FACTURE);

--Nom, prénom, telephone des clients qui ont une facture

select distinct CLI_NOM,CLI_PRENOM,TEL_NUMERO
from T_CLIENT,T_TELEPHONE
where T_CLIENT.CLI_ID in (select CLI_ID from T_FACTURE)
and T_CLIENT.CLI_ID = T_TELEPHONE.CLI_ID

--Attention si email car pas obligatoire : jointure externe

--Adresse où envoyer factures aux clients

select ADR_LIGNE1 
from T_ADRESSE;

--Répartition des factures par mode de paiement (libellé)

select FAC_ID,PMT_LIBELLE
from T_FACTURE,T_MODE_PAIEMENT
where  T_FACTURE.PMT_CODE = T_MODE_PAIEMENT.PMT_CODE
order by PMT_LIBELLE;

--Répartition des factures par mode de paiement 

select FAC_ID, T_FACTURE.PMT_CODE
from T_FACTURE,T_MODE_PAIEMENT
where  T_FACTURE.PMT_CODE = T_MODE_PAIEMENT.PMT_CODE
order by  T_FACTURE.PMT_CODE;

--Différence entre ces 2 requêtes ? 

/*L'un utilise le PMT_CODE et l'autre le PMT_LIBELLE*/

--Factures sans mode de paiement 

select FAC_ID, T_FACTURE.PMT_CODE
from T_FACTURE,T_MODE_PAIEMENT
where  T_FACTURE.PMT_CODE = T_MODE_PAIEMENT.PMT_CODE
and T_FACTURE.PMT_CODE = "null";

--Repartition des factures par Années

select *
from T_FACTURE 
order by FAC_DATE 

--Repartition des clients par ville

select CLI_NOM
from T_CLIENT,T_ADRESSE
where T_CLIENT.CLI_ID = T_ADRESSE.CLI_ID
order by ADR_VILLE

--Montant TTC de chaque ligne de facture (avec remises)

--Classement du montant total TTC (avec remises) des factures

--Tarif moyen des chambres par années croissantes

--Tarif moyen des chambres par étage et années croissantes

--Chambre la plus cher et en quelle année

--Chambre la plus cher par année 

--Clasement décroissant des réservation des chambres 

--Classement décroissant des meilleurs clients par nombre de réservations

--Classement des meilleurs clients par le montant total des factures

--Factures payées le jour de leur édition

select *
from T_FACTURE
where FAC_DATE = FAC_PMT_DATE;

--Facture dates et Délai entre date de paiement et date d'édition de la facture