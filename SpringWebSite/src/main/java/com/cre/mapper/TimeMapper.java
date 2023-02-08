package com.cre.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	@Select("SELECT now() From dual")
	public String getTime();
	public String getTime2();
}