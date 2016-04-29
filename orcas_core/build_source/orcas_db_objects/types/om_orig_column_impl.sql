create or replace type om_orig_column_impl force under om_orig_column
(
  overriding member function is_child_order_relevant return number,
  overriding member function get_merge_result( p_diff_values in out nocopy cd_orig_column_list, p_old_values in ct_orig_column_list ) return ct_merge_result_list,
  overriding member function cleanup_values( p_value in out nocopy ot_orig_column ) return number
)
/
create or replace type body om_orig_column_impl is
  
  overriding member function is_child_order_relevant return number
  is
  begin
    return 0;
  end;

  overriding member function get_merge_result( p_diff_values in out nocopy cd_orig_column_list, p_old_values in ct_orig_column_list ) return ct_merge_result_list is
    v_merge_result ct_merge_result_list := new ct_merge_result_list();
  begin
    v_merge_result.extend(p_old_values.count());
    
    for i in 1..p_old_values.count()
    loop
      v_merge_result(i) := new ot_merge_result(null);          
      
      for j in 1..p_diff_values.count()
      loop
        if( p_old_values(i).i_name = p_diff_values(j).n_name )
        then
          v_merge_result(i).i_merge_index := j;
        end if;
      end loop;
    end loop;
  
    return v_merge_result;
  end;
  
  overriding member function cleanup_values( p_value in out nocopy ot_orig_column ) return number
  is
  begin
    if( (self as om_orig_column).cleanup_values( p_value ) = null ) then null; end if;
    
    if( p_value.i_precision is null )
    then
      if( ot_orig_datatype.is_equal( p_value.i_data_type, ot_orig_datatype.c_float ) = 1 )
      then
        p_value.i_precision := 126;
      end if;
      if( ot_orig_datatype.is_equal( p_value.i_data_type, ot_orig_datatype.c_timestamp ) = 1 )
      then
        p_value.i_precision := 6;
      end if;      
      if( ot_orig_datatype.is_equal( p_value.i_data_type, ot_orig_datatype.c_char ) = 1 )
      then
        p_value.i_precision := 1;
      end if;       
    end if;
    
    return null;
  end;    
  
end;
/
