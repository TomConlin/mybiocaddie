COPY(
select 
	'layout: ', 'dataset',
	'title: ', dataset.title,
	'date: ', now()::DATE,
	'categories: ', 'Exposome Phenotype Genotype',
	'index: ', 'biocaddie',
	----------------------------------------
	'type: ', 'http://purl.org/dc/dcmitype/Dataset',
	'datatypes: ', array(select distinct data_type from dataset_data_type where dataset_id = dataset.id),
	'identifier: ', dataset.accession,
	'rights: ', 'https://www.facebase.org/methods/policies/',
	--'accessURL:', 'https://www.facebase.org/hatrac/facebase/data/fb1/' || dataset.accession ||'.zip',
	'page: ', 'https://www.facebase.org/data/record/#1/legacy:dataset/id=' || dataset.id,
	'taxa: ', dataset_organism.organism,
	'references: ', dataset.pubmed_id,
	'author: ', first_name || ' ' || last_name,
	'summary: ', dataset.summary
 from person 
	join project_investigator on person.username = project_investigator.username
	join dataset on dataset.project = project_id
	--join file on dataset.thumbnail = file.id -- only null timestamps
	join dataset_organism
	on dataset.id = dataset_organism.dataset_id
	where first_name = 'Axel' 
	and last_name = 'Visel'
) to '/tmp/facebase_AV_dataset.unl' ;

