package egovframework.subBoard.model.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class SubBoardServicePractice {

	@Resource(name="subBoardMapperPractice")
	private SubBoardMapperPractice subBoardMapperPractice;

	public int deleteBoard(int subBno) {
		
		System.out.println("subBno2: " + subBno);
		return subBoardMapperPractice.deleteBoard(subBno);
	}
	
	
}
