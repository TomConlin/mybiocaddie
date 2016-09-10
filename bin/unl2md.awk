#! /usr/bin/awk -f

# generate column numbers 
# head -1 facebase_AV_dataset.unl | awk -F"\t" '{for(i=1;i<=NF;i+=2)print $i}' | grep -n . | awk -F":" '{print "col[\"" $2 "\"]="($1*2-1)}'

# get next 
function select(n){return n+1}



BEGIN{
	FS="\t";
	OFS="";
	txid["Mouse"]="NCBITaxon:10090";
	txid["Zebrafish"]="NCBITaxon:7955";
	txid["Human"]="NCBITaxon:9606";
col["layout"]=1;
col["title"]=3;
col["date"]=5;
col["categories"]=7;
# col["index"]=9;  # index is an unfortunate choice here
col["type"]=11;
col["datatypes"]=13;
col["identifier"]=15;
col["rights"]=17;
col["page"]=19;
col["taxa"]=21;
col["references"]=23;
col["author"]=25;
col["summary"]=27;
}
{	file= $(select(col["identifier"])) ".md"
	$1 = "---\n" $1
	$(select(col["title"])) = "\"" $(select(col["title"]))  "\""
	sub("{","[",$(select(col["datatypes"])));
	sub("}","]",$(select(col["datatypes"])))
	$(select(col["taxa"]))=txid[$(select(col["taxa"]))]
	if($(select(col["references"]))=="\\N"){
		$(col["references"])=$(select(col["references"]))=""}
	else{
		$(select(col["references"]))="PMID:" $(select(col["references"]))}
	$(select(col["author"])) = "\"" $(select(col["author"]))  "\""
	$(col["summary"]) = "\n---\n"
	for(i=2;i<=NF;i+=2){$ i= $i "  \n"}
	print > file
}

# head -1 facebase_AV_dataset.unl | awk -F"\t" '{for(i=1;i<=NF;i+=2)print $i}' | grep -n . | awk -F":" '{print ($1*2-1),$2}'

#1 layout
#3 title
#5 date
#7 categories
#9 index
#11 type
#13 datatypes
#15 identifier
#17 rights
#19 page
#21 taxa
#23 references
#25 author
#27 summary


