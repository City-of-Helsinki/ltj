-- Virkaversio kääpäkohteet:

CREATE OR REPLACE VIEW ltj_wfs_virka.arvo_kaapakohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=163&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'KAAP'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
                                                                                      
-- Virkaversio liito-oravien ydinalueet:

CREATE OR REPLACE VIEW ltj_wfs_virka.arvo_liito_orava AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=296&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LIIT'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio metsäkohteet:

CREATE OR REPLACE VIEW ltj_wfs_virka.arvo_metsakohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=164&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'METS'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio tärkeät lepakkoalueet:

CREATE OR REPLACE VIEW ltj_wfs_virka.arvo_tarkeat_lepakkoalueet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=160&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'LEPA'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio tärkeät matelija- ja sammakkoeläinkohteet:

CREATE OR REPLACE VIEW ltj_wfs_virka.arvo_tarkeat_matelija_ja_sammakkoelainkohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=161&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'MASA'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio arvokkaat geologiset kohteet aluemaiset:

CREATE OR REPLACE VIEW ltj_wfs_virka.arvokkaat_geologiset_aluemaiset AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
	luokka.nimi AS luokan_nimi,
	kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
	array_to_string(array_agg(arvo.luokka), ', '::text) AS arvoluokka,
    array_to_string(array_agg(arvo.selite), ', '::text) AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=162&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'GK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1)AND
  ((GeometryType(geometry1))::text Like '%POLYGON'::text))
    GROUP BY kohde.id, luokka.nimi;
  
  -- Virkaversio arvokkaat geologiset kohteet viivamaiset:
  
CREATE OR REPLACE VIEW ltj_wfs_virka.arvokkaat_geologiset_viivamaiset AS
  SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
	luokka.nimi AS luokan_nimi,
	kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
	array_to_string(array_agg(arvo.luokka), ', '::text) AS arvoluokka,
    array_to_string(array_agg(arvo.selite), ', '::text) AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=162&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'GK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1)AND
  ((GeometryType(geometry1))::text Like '%LINE%'::text))
    GROUP BY kohde.id, luokka.nimi;

-- Virkaversio arvokkaat kasvikohteet:

CREATE OR REPLACE VIEW ltj_wfs_virka.arvokkaat_kasvikohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=153&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'KK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio arvokkaat lintukohteet:

CREATE OR REPLACE VIEW ltj_wfs_virka.arvokkaat_lintukohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=159&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'LK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio eläinhavainnot:

CREATE OR REPLACE VIEW ltj_wfs_virka.muu_elainhavaintoja AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    lajirekisteri.nimi_suomi1 AS lajinimi,
    lajihavainto.pvm AS havainnon_paivamaara,
    havaintosarja.nimi AS havaintosarjan_nimi,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=168&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM ((((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     JOIN ltj.lajihavainto ON ((kohde.id = lajihavainto.kohdeid)))
     JOIN ltj.lajirekisteri ON ((lajirekisteri.id = lajihavainto.lajid)))
     JOIN ltj.havaintosarja ON ((lajihavainto.hsaid = havaintosarja.id)))
  WHERE (((kohde.luokkatunnus)::text = 'EK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio perinnemaisemat:
-- huom avoimen datan puolella ei perinnemaisemia, koska aineisto ei ole kokonaan Helsingin omistuksessa

CREATE OR REPLACE VIEW ltj_wfs_virka.muu_perinnemaisemat AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
	array_to_string(array_agg(arvo.luokka), ', '::text) AS arvoluokka,
    array_to_string(array_agg(arvo.selite), ', '::text) AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=169&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text))
	      LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'PM'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1))
  GROUP BY kohde.id, luokka.nimi;

-- Virkaversio muut luontokohteet:

CREATE OR REPLACE VIEW ltj_wfs_virka.muut_luontokohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=170&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'MUU'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio rauhoitetut luonnonmuistomerkit:

CREATE OR REPLACE VIEW ltj_wfs_virka.rauh_luonnonmuistomerkit AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=157&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Lmm'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio rauhoitetut luonnonsuojelualueet:

CREATE OR REPLACE VIEW ltj_wfs_virka.rauh_luonnonsuojelualueet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=154&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Lsa'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio rauhoitettavat luonnonsuojeluohjelma:

CREATE OR REPLACE VIEW ltj_wfs_virka.rauh_luonnonsuojeluohjelma AS
 SELECT kohde.id,
    kohde.tunnus,
    'LSO'::character varying(10) AS luokkatunnus,
    'Luonnonsuojeluohjelman kohde'::character varying(50) AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=158&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Kaava'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio rauhoitetut Natura aluemaiset:

CREATE OR REPLACE VIEW ltj_wfs_virka.rauh_natura_aluemaiset AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=155&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Natur'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1) AND
  ((GeometryType(geometry1))::text Like '%POLYGON'::text));
                                                                                       
-- Virkaversio rauhoitetut Natura viivamaiset:
                 
CREATE OR REPLACE VIEW ltj_wfs_virka.rauh_natura_viivamaiset AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=155&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Natur'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1) AND
  ((GeometryType(geometry1))::text Like '%LINE%'::text));

-- Virkaversio suojellut luontotyypit:

CREATE OR REPLACE VIEW ltj_wfs_virka.rauh_suojellut_luontotyypit AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    suoperuste.peruste,
    suoperuste.tarkperuste,
    suoperuste.alaperuste,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=156&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM ((((ltj.kohde
     JOIN ltj.suojelu ON ((kohde.id = suojelu.id)))
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.suo_peruste ON ((suojelu.id = suo_peruste.suoid)))
     LEFT JOIN ltj.suoperuste ON ((suo_peruste.perusteid = suoperuste.id)))
  WHERE (((kohde.luokkatunnus)::text = 'LslLt'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

  -- Virkaversio suojellut lajikohteet:

CREATE OR REPLACE VIEW ltj_wfs_virka.suojellut_lajikohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=174&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM ((ltj.kohde
     JOIN ltj.suojelu ON ((kohde.id = suojelu.id)))
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Slaji'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio vesi - lähteet:

CREATE OR REPLACE VIEW ltj_wfs_virka.vesi_lahteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=167&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LAH'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

  -- Virkaversio vesi - purojen ja lampien valuma-alueet:

CREATE OR REPLACE VIEW ltj_wfs_virka.vesi_purojen_ja_lampien_valuma_alueet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=166&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'PPV'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio vesi - purojen putkitetut osuudet:

CREATE OR REPLACE VIEW ltj_wfs_virka.vesi_purojen_putkitetut_osuudet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=269&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'PPUT'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio vesi - purot:

CREATE OR REPLACE VIEW ltj_wfs_virka.vesi_purot AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=165&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'PPO'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

  -- Virkaversio vesi - lammet:

CREATE OR REPLACE VIEW ltj_wfs_virka.vesi_lammet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=165&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LAM'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
  
-- Virkaversio vedenlainen roskaantuminen:

CREATE OR REPLACE VIEW ltj_wfs_virka.vesi_vedenalainen_roskaantuminen AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=291&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'ROSK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));

-- Virkaversio vesikasvilinjat:

CREATE OR REPLACE VIEW ltj_wfs_virka.vesi_vesikasvilinjat AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=289&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LITO'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
                                                                                      
-- Virkaversio uhanalaiset luontotyypit:

CREATE OR REPLACE VIEW ltj_wfs_virka.uhanalaiset_luontotyypit AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=345&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'UHLT'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
                                                                                      
 -- Virkaversio lahokaviosammalen elinympäristöt
                                                                                      
CREATE OR REPLACE VIEW ltj_wfs_virka.lahokaviosammal_elinymparistot AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=327&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LKSE'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
                                                                                      
  -- Virkaversio tärkeät lintualueet 2017:

CREATE OR REPLACE VIEW ltj_wfs_virka.tarkeat_lintualueet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
	arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=340&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text))
	      LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'LK2'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));     
                                                                                     
-- Virkaversio biotooppikohteet

CREATE OR REPLACE VIEW ltj_wfs_virka.biotoopit AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=180&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'BK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
                                                                                    
-- Virkaversio vesi - kunnostetut purokohdat

CREATE OR REPLACE VIEW ltj_wfs_virka.kunnostetut_purokohdat AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=308&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'KUNN'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
                                                                                      
-- Virkaversio ekologisten yhteyksien verkosto

CREATE OR REPLACE VIEW ltj_wfs_virka.ekologiset_yhteydet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=322&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'VYHT'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
                                                                                      
 -- Virkaversio metsäverkosto

CREATE OR REPLACE VIEW ltj_wfs_virka.metsaverkosto AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.suojaustasoid,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
    kohde.teksti AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=322&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'MVER'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid <> 1));
                                                                                      
-- Avoin data arvokkaat kääpäkohteet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvo_kaapakohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=163&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'KAAP'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data liito-oravien ydinalueet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvo_liito_orava AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=296&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LIIT'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data metsäkohteet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvo_metsakohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=164&l=fi'::text AS metadata
	 ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'METS'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data tärkeät lepakkoalueet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvo_tarkeat_lepakkoalueet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=160&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'LEPA'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data tärkeät matelija ja sammakkoeläinkohteet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvo_tarkeat_matelija_ja_sammakkoelainkohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=161&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'MASA'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data arvokkaat geologiset kohteet aluemaiset:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvokkaat_geologiset_aluemaiset AS
   SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
	luokka.nimi AS luokan_nimi,
	kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
           CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
	array_to_string(array_agg(arvo.luokka), ', '::text) AS arvoluokka,
    array_to_string(array_agg(arvo.selite), ', '::text) AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=162&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'GK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3)AND
  ((GeometryType(geometry1))::text Like '%POLYGON'::text))
    GROUP BY kohde.id, luokka.nimi;
  
  -- Avoin data arvokkaat geologiset kohteet viivamaiset:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvokkaat_geologiset_viivamaiset AS
   SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
	luokka.nimi AS luokan_nimi,
	kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
         CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
	array_to_string(array_agg(arvo.luokka), ', '::text) AS arvoluokka,
    array_to_string(array_agg(arvo.selite), ', '::text) AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=162&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'GK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3)AND
  ((GeometryType(geometry1))::text Like '%LINE%'::text))
    GROUP BY kohde.id, luokka.nimi;

-- Avoin data arvokkaat kasvikohteet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvokkaat_kasvikohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=153&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'KK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data arvokkaat lintukohteet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.arvokkaat_lintukohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    arvo.luokka AS arvoluokka,
    arvo.selite AS arvoluokan_selite,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=159&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.arvo_kohde ON ((kohde.id = arvo_kohde.kohdeid)))
     LEFT JOIN ltj.arvo ON ((arvo_kohde.arvoid = arvo.id)))
  WHERE (((kohde.luokkatunnus)::text = 'LK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data muut eläinhavainnot:

CREATE OR REPLACE VIEW ltj_wfs_avoin.muu_elainhavaintoja AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    lajirekisteri.nimi_suomi1 AS lajinimi,
    lajihavainto.pvm AS havainnon_paivamaara,
    havaintosarja.nimi AS havaintosarjan_nimi,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=168&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM ((((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     JOIN ltj.lajihavainto ON ((kohde.id = lajihavainto.kohdeid)))
     JOIN ltj.lajirekisteri ON ((lajirekisteri.id = lajihavainto.lajid)))
     JOIN ltj.havaintosarja ON ((lajihavainto.hsaid = havaintosarja.id)))
  WHERE (((kohde.luokkatunnus)::text = 'EK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data muut luontokohteet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.muut_luontokohteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=170&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'MUU'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data rauhoitetut luonnonmuistomerkit:

CREATE OR REPLACE VIEW ltj_wfs_avoin.rauh_luonnonmuistomerkit AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=157&l=fi'::text AS metadata
	 ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Lmm'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data luonnonsuojelualueet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.rauh_luonnonsuojelualueet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=154&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Lsa'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data rauhoitetut luonnonsuojeluohjelmat:

CREATE OR REPLACE VIEW ltj_wfs_avoin.rauh_luonnonsuojeluohjelma AS
 SELECT kohde.id,
    kohde.tunnus,
    'LSO'::character varying(10) AS luokkatunnus,
    'Luonnonsuojeluohjelman kohde'::character varying(50) AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=158&l=fi'::text AS metadata
	 ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'Kaava'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data rauhoitetut naturat aluemaiset:

CREATE OR REPLACE VIEW ltj_wfs_avoin.rauh_natura AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
       CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=155&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
    WHERE (((kohde.luokkatunnus)::text = 'Natur'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3) AND
  ((GeometryType(geometry1))::text Like '%POLYGON'::text));
                 
-- Avoin data rauhoitetut natura viivamaiset:

CREATE OR REPLACE VIEW ltj_wfs_avoin.rauh_natura_viivamaiset AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
       CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=155&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
    WHERE (((kohde.luokkatunnus)::text = 'Natur'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3) AND
  ((GeometryType(geometry1))::text Like '%LINE%'::text));

-- Avoin data suojellut luontotyypit:

CREATE OR REPLACE VIEW ltj_wfs_avoin.rauh_suojellut_luontotyypit AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    suoperuste.peruste,
    suoperuste.tarkperuste,
    suoperuste.alaperuste,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=156&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM ((((ltj.kohde
     JOIN ltj.suojelu ON ((kohde.id = suojelu.id)))
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     LEFT JOIN ltj.suo_peruste ON ((suojelu.id = suo_peruste.suoid)))
     LEFT JOIN ltj.suoperuste ON ((suo_peruste.perusteid = suoperuste.id)))
  WHERE (((kohde.luokkatunnus)::text = 'LslLt'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data vesi - lähteet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.vesi_lahteet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=167&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LAH'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data vesi - purojen ja lampien valuma-alueet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.vesi_purojen_ja_lampien_valuma_alueet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=166&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'PPV'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data vesi - purojen putkitetut osuudet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.vesi_purojen_putkitetut_osuudet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=269&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'PPUT'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data vesi - purot:

CREATE OR REPLACE VIEW ltj_wfs_avoin.vesi_purot AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=165&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'PPO'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

  
  -- Avoin data vesi - lammet:

CREATE OR REPLACE VIEW ltj_wfs_avoin.vesi_lammet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=165&l=fi'::text AS metadata
	('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LAM'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));
  
-- Avoin data vedenalainen roskaantuminen:

CREATE OR REPLACE VIEW ltj_wfs_avoin.vesi_vedenalainen_roskaantuminen AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=291&l=fi'::text AS metadata
	 ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'ROSK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));

-- Avoin data vesikasvilinjat:

CREATE OR REPLACE VIEW ltj_wfs_avoin.vesi_vesikasvilinjat AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=289&l=fi'::text AS metadata
	 ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LITO'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));
                                                                                      
-- Avoin data uhanalaiset luontotyypit:

CREATE OR REPLACE VIEW ltj_wfs_avoin.uhanalaiset_luontotyypit AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
        CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=345&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'UHLT'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));   
                                                                                      
 -- Avoin data lahokaviosammalen elinympäristöt
                                                                                      
CREATE OR REPLACE VIEW ltj_wfs_avoin.lahokaviosammal_elinymparistot AS
  SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
     CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=327&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LKSE'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));
                                                                                      
   -- Avoin data tärkeät lintualueet 2017:

CREATE OR REPLACE VIEW ltj_wfs_avoin.tarkeat_lintualueet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
      CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=340&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'LK2'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));  
                                                                                     
  
 -- Avoin data biotooppikohteet

CREATE OR REPLACE VIEW ltj_wfs_avoin.biotoopit AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
      CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=180&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'BK'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));
                                                                                    
-- Avoin data ekologisten yhteyksien verkosto

CREATE OR REPLACE VIEW ltj_wfs_avoin.ekologiset_yhteydet AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
       CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=322&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'VYHT'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));
                                                                                      
-- Avoin data metsäverkosto

CREATE OR REPLACE VIEW ltj_wfs_avoin.metsaverkosto AS
 SELECT kohde.id,
    kohde.tunnus,
    kohde.luokkatunnus,
    luokka.nimi AS luokan_nimi,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.digipvm,
    kohde.pvm_editoitu,
    kohde.digitoija,
    kohde.muokkaaja,
    kohde.pinta_ala AS pinta_ala_ha,
    kohde.geometry1,
       CASE
            WHEN (NOT ((kohde.teksti_www)::text = ''::text)) THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS kohdeteksti,
    'https://kartta.hel.fi/paikkatietohakemisto/metadata/?id=322&l=fi'::text AS metadata,
    ('https://kartta.hel.fi/applications/ltj/reports/kohderaportti.aspx?id='::text || kohde.id) AS kohderaportti
   FROM (ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
  WHERE (((kohde.luokkatunnus)::text = 'MVER'::text) AND (kohde.voimassa = true) AND (kohde.suojaustasoid = 3));
  

-- ltj_kohteet-view for SpatialWeb

CREATE OR REPLACE VIEW ltj.ltj_kohteet AS
SELECT kohde.id,
    st_geometryn(st_force2d(kohde.geometry1), 1)::geometry(Geometry,3879) AS geometry1,
    kohde.tunnus,
    kohde.luokkatunnus,
    kohde.nimi,
    kohde.kuvaus,
    kohde.huom,
    kohde.voimassa,
    kohde.numero,
    kohde.pinta_ala,
    kohde.suojaustasoid AS suojaustasokohde,
    kohde.teksti AS tieto,
        CASE
            WHEN NOT kohde.teksti_www::text = ''::text THEN kohde.teksti_www
            ELSE kohde.teksti
        END AS tieto_www,
    array_to_string(array_agg(arvo.luokka), ','::text) AS suojelu_arvo_luokka,
    array_to_string(array_agg(arvo.selite), ', '::text) AS suojelu_arvo_selite
   FROM ltj.kohde
     LEFT JOIN ltj.arvo_kohde ON arvo_kohde.kohdeid = kohde.id
     LEFT JOIN ltj.arvo ON arvo.id = arvo_kohde.arvoid
  WHERE kohde.voimassa AND st_isvalid(kohde.geometry1)
  GROUP BY kohde.id;

  
-- ltj_lajikohteet-view for SpatialWeb
  
CREATE OR REPLACE VIEW ltj.ltj_lajikohteet AS
 SELECT kohde.id,
    kohde.luokkatunnus,
    kohde.tunnus,
    kohde.nimi,
    (public.st_geometryn(public.st_force2d(kohde.geometry1), 1))::public.geometry(Geometry,3879) AS geometry1,
    kohde.suojaustasoid AS suojaustasokohde,
    lajihavainto.suojaustasoid AS suojaustasohavainto,
    lajirekisteri.suojaustasoid AS suojaustasolaji,
    luokka.nimi AS luokka,
    lajihavainto.lajid
   FROM (((ltj.kohde
     JOIN ltj.luokka ON (((luokka.tunnus)::text = (kohde.luokkatunnus)::text)))
     JOIN ltj.lajihavainto ON ((kohde.id = lajihavainto.kohdeid)))
     JOIN ltj.lajirekisteri ON ((lajihavainto.lajid = lajirekisteri.id)))
  WHERE (kohde.voimassa AND public.st_isvalid(kohde.geometry1));


  -- New table for service metadata
  
 CREATE TABLE jakelumetadata (
    id integer NOT NULL,
    datanomistaja character varying(25),
    paivitetty_tietopalveluun date,
); 
