do $$ declare acc_id VARCHAR(10) = '3725814024';
acc_nm VARCHAR(100) = '';
_result integer = 0;
begin 
select 
  name into acc_nm 
from 
  raw_input.account a 
where 
  a.real_id :: text = acc_id;
raise notice 'Account name-%', 
acc_nm;

if acc_nm !='' then
	------delete insights----------------
	delete from 
	  raw_input.metric_raw_value 
	where 
	  asset_id in (
	    select 
	      id 
	    from 
	      raw_input.asset 
	    where 
	      account_id in (
	        select 
	          id 
	        from 
	          raw_input.account 
	        where 
	          real_id = acc_id
	      )
	  );
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.metric_raw_value', 
	_result;
	end if;
	----------------delete asset_l1------------
	delete from 
	  raw_input.asset_l1 
	where 
	  asset_id in (
	    select 
	      id 
	    from 
	      raw_input.asset 
	    where 
	      account_id in (
	        select 
	          id 
	        from 
	          raw_input.account 
	        where 
	          real_id = acc_id
	      )
	  );
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.asset_l1', 
	_result;
	end if;
	----------------delete asset_l2------------
	delete from 
	  raw_input.asset_l2 
	where 
	  asset_id in (
	    select 
	      id 
	    from 
	      raw_input.asset 
	    where 
	      account_id in (
	        select 
	          id 
	        from 
	          raw_input.account 
	        where 
	          real_id = acc_id
	      )
	  );
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.asset_l2', 
	_result;
	end if;
	----------------delete asset_l0------------
	delete from 
	  raw_input.asset_l0 
	where 
	  asset_id in (
	    select 
	      id 
	    from 
	      raw_input.asset 
	    where 
	      account_id in (
	        select 
	          id 
	        from 
	          raw_input.account 
	        where 
	          real_id = acc_id
	      )
	  );
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.asset_l0', 
	_result;
	end if;
	-------------delete meta deta history------------
	delete from 
	  raw_input.asset_metadata_history 
	where 
	  asset_id in (
	    select 
	      id 
	    from 
	      raw_input.asset 
	    where 
	      account_id in (
	        select 
	          id 
	        from 
	          raw_input.account 
	        where 
	          real_id = acc_id
	      )
	  );
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.asset_metadata_history', 
	_result;
	end if;
	-----------delete metric assets-----------
	delete from 
	  raw_input.metrics_assets 
	where 
	  asset_id in (
	    select 
	      id 
	    from 
	      raw_input.asset 
	    where 
	      account_id in (
	        select 
	          id 
	        from 
	          raw_input.account 
	        where 
	          real_id = acc_id
	      )
	  );
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.metrics_assets', 
	_result;
	end if;
	--------------delete asset scan history-------------
	delete from 
	  raw_input.asset_scan_history 
	where 
	  asset_id in (
	    select 
	      id 
	    from 
	      raw_input.asset 
	    where 
	      account_id in (
	        select 
	          id 
	        from 
	          raw_input.account 
	        where 
	          real_id = acc_id
	      )
	  );
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.asset_scan_history', 
	_result;
	end if;
	-------------delete asset-----------
	delete from 
	  raw_input.asset 
	where 
	  account_id in (
	    select 
	      id 
	    from 
	      raw_input.account 
	    where 
	      real_id = acc_id
	  );
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.asset', 
	_result;
	end if;
	---------------delete account---------------
	delete from 
	  raw_input.account 
	where 
	  real_id = acc_id;
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.account', 
	_result;
	end if;
	----------------delete custom conversion actions-------------
	delete from 
	  raw_input.metric m 
	where 
	  m."path" like 'customers/' || acc_id || '%';
	get diagnostics _result = ROW_COUNT;
	if _result > 0 then raise notice 'Removed % rows from raw_input.metric', 
	_result;
	end if;
else
 raise notice 'Account Id- % does not exists in database',acc_id;
end if;
end;
$$;
