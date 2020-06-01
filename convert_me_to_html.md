



  * Query to get new data (ukcdh\cdh_uk\assets\configs\dimensions_prod.yaml):
    * ````sql

          SELECT tu_d.dea_cd a_famos_retailer, tu_d.dea_nu_seal a_seal_retailer
        		 , (CASE WHEN (tu_dg.dag_cd IS NULL) THEN 'N/A' ELSE tu_dg.dag_cd END) a_retailer_group_code
        		 , (CASE WHEN (tu_dg.dag_va_name IS NULL) THEN 'N/A' ELSE tu_dg.dag_va_name END) a_retailer_group_name
        		 , tu_b.bra_des a_famos_retailer_brand
        		 , tu_cr.rec_des a_sales_region
        		 , (CASE tu_d.dea_bl_disabled WHEN 1 THEN 'NO' ELSE 'YES' END) a_famos_enabled
        		 , tu_d.dea_va_comp_name a_retailer_name
         	  FROM (
         	  			(
         	  				(
         	  					(famos_prod_db.famos_v_dar_tu_dealer /*a*/ tu_d INNER JOIN ( SELECT max(ingesttimestamp) max_ingtmstp
         	  																				  FROM famos_prod_db.famos_v_dar_tu_dealer /*a*/
         	  																			  )  tu_d_max_tmstmp ON (tu_d.ingesttimestamp = tu_d_max_tmstmp.max_ingtmstp)
         	  					)
         	  					LEFT JOIN (famos_prod_db.famos_v_dar_tu_dealer_group /*b*/ tu_dg INNER JOIN ( SELECT max(ingesttimestamp) max_ingtmstp
         	  																								   FROM famos_prod_db.famos_v_dar_tu_dealer_group /*b*/
         	  																							   ) tu_dg_max_tmstmp ON (tu_dg.ingesttimestamp = tu_dg_max_tmstmp.max_ingtmstp)
         	  							  ) ON (tu_d.dag_id = tu_dg.dag_id)

         	  				) INNER JOIN (famos_prod_db.famos_v_dar_tu_brand /*c*/ tu_b INNER JOIN (SELECT max(ingesttimestamp) max_ingtmstp
         	  																						 FROM famos_prod_db.famos_v_dar_tu_brand /*c*/
         	  																					  ) tu_b_max_tmstmp ON (tu_b.ingesttimestamp = tu_b_max_tmstmp.max_ingtmstp)
         	  							 ) ON (tu_d.bra_id = tu_b.bra_id)
         	  			) INNER JOIN (famos_prod_db.famos_v_dar_tu_commercial_region /*d*/ tu_cr INNER JOIN (SELECT max(ingesttimestamp) max_ingtmstp
         	  																								  FROM famos_prod_db.famos_v_dar_tu_commercial_region /*d*/
         	  																							   ) tu_cr_max_tmstmp ON (tu_cr.ingesttimestamp = tu_cr_max_tmstmp.max_ingtmstp)
         	  						 ) ON (tu_d.rec_id = tu_cr.rec_id)
         	  	    )

      ````

  * Returns several records ("famos_v_dar_tu_dealer.dea_id") for the same "famos_v_dar_tu_dealer.dea_cd"    

      |a_famos_retailer|a_seal_retailer|a_retailer_group_code|a_retailer_group_name|a_famos_retailer_brand|a_sales_region|a_famos_enabled|a_retailer_name|
      |----------------|---------------|---------------------|---------------------|----------------------|--------------|---------------|---------------|
      |2408051|2408051|207|FG Barnes|Alphera|A6|NO|FG Barnes Guildford|
      |2408051|2408051|N/A|N/A|Alphera|Alphera 99|NO|FG Barnes Ltd - Terminated|

  * During the job (**ukcdh-prod-eu-west-1-update_dim_retailer**) run, we check want changes exist between the current **D_RETAILER** state and the one we're trying to update it with.

  * What i think is happening is that, for example, if the current    
