package egovframework.subBoard.model.service;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("subBoardMapperPractice")
public interface SubBoardMapperPractice {
	
	public int deleteBoard(int subBno);

}
