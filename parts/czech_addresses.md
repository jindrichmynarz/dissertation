### Czech addresses

In order to provide the postal addresses in the Czech public procurement data with geo-coordinates, we extracted Czech address data from the [Registry of territorial identification, addresses, and real estate](http://www.cuzk.cz/Uvod/Produkty-a-sluzby/RUIAN/RUIAN.aspx) (RÚIAN).
The registry contained 2.9 million addresses^[Valid as of September 2016.] in the Czech republic.
Each address is linked to one of the Czech municipalities.
The addresses refer to locations of buildings that can be assigned unambiguous addresses.^[See the [definition](https://www.czso.cz/csu/rso/adresni_misto).]
Most addresses are provided with address points that are chosen to be representative of the addresses.
For example, geo-coordinates of an address point may be located at the entrance of a building its address is assigned to.

The Czech address data is [available in CSV](https://nahlizenidokn.cuzk.cz/StahniAdresniMistaRUIAN.aspx).
We used LP-ETL to transform the source data to RDF.
Each address was modelled as an instance of [`schema:PostalAddress`](http://schema.org/PostalAddress).
The RÚIAN-specific attributes, such as the orientational number or the building type, were described with the RÚIAN Ontology previously developed by the OpenData.cz initiative.
Since each row in the source data is independent of the others, it was possible to use chunked transformation to process smaller batches of rows separately and thus decrease the execution time of the transformation.
The resulting data consisting of 42 million RDF triples was loaded into a Virtuoso RDF store. 

Czech addreses data use Systém Jednotné trigonometrické sítě katastrální (S-JTSK)[^S-JTSK] as its coordinate reference system.
S-JTSK is based on the Křovák projection, which was designed specifically for the Czechoslovakia to provide more precise geo-coordinates than another reference system would.
However, the standard coordinate reference system used in web applications is the World Geodetic System (WGS84).
Data using S-JTSK are thus not directly interoperable with many existing datasets.
If data adhering to multiple coordinate reference systems are to be used together, they must be reprojected to a single coordinate reference system to make them comparable.
The loss of precision caused by the reprojection is minute.
The error in the conversion from S-JTSK to WGS84 using a transformation key is below 1 meter.
The largest error, nearing 1 meter, can be observed for geo-coordinates [near the borders of the Czech Republic](http://freegis.fsv.cvut.cz/gwiki/S-JTSK_/_Chyba_p%C5%99i_transformaci_z_WGS84_do_S-JTSK).
We therefore decided to trade a loss in precision for increased interoperability and reproject S-JTSK to WGS84.

At the time the data was transformed (September 2016) LP-ETL did not support reprojection of geo-coordinates.
In its current version (as of January 2017) it features a [component](https://github.com/linkedpipes/etl/tree/master/plugins/t-geoTools) that offers this functionality. 
We thus implemented the reprojection as a separate step following the data transformation in LP-ETL.
We developed a command-line tools that requested the original geo-coordinates in paged batches using SPARQL SELECT queries, reprojected them, and uploaded the batches back to the RDF store using SPARQL Update operations.
Geo-coordinates were reprojected using the open-source [GeoTools](http://www.geotools.org) Java library.

Since 2011 Czech addresses use the [EPSG:5514](http://epsg.io/5514) variant of the S-JTSK coordinate reference system according to its documentation.
Till 2011 the variant in use was [EPSG:2065](http://epsg.io/2065).
Contrary to the documentation we discovered that the reprojection delivered more precise results when EPSG:2065 was used instead of EPSG:5514, when compared to the results of the RÚIAN reprojection service.^[<http://geoportal.cuzk.cz/(S(dz3yiewehucysxhe2piompn3))/Default.aspx?mode=TextMeta&text=wcts&menu=19>]
We may ascribe this difference either to the precision of the transformation keys that were used for the compared variants.
Nevertheless, the differences among the variants ranged in centimeters, so that they were negligible for the purposes we wanted to use the geo-coordinates.

In fact, the reprojection of the Czech addresses geo-coordinates would not be necessary if we only computed distances within this dataset.
However, the reprojection was needed in order to be able to compare the geo-coordinates with WGS84 geo-coordinates produced by geocoding services for evaluation of geocoding, which we describe further.
Moreover, the reprojection to a standard coordinate reference system generally improved the ease of use of the data.
For example, map visualizations, that are typically done using software libraries expecting WGS84 geo-coordinates, could avoid using to on-the-fly reprojections of the data. 

[^S-JTSK]: See the [documentation](http://vdp.cuzk.cz/vymenny_format/csv/ad-csv-struktura.pdf) of the Czech address data.
