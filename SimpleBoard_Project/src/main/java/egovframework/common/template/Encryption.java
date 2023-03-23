package egovframework.common.template;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;

import egovframework.rte.fdl.cryptography.EgovCryptoService;
import egovframework.rte.fdl.cryptography.EgovPasswordEncoder;

public class Encryption {
    @Resource(name = "ARIACryptoService")
    private static EgovCryptoService egovCryptoService;

    @Resource(name = "passwordEncoder")
    private EgovPasswordEncoder passwordEncoder;

    public static void main(String[] args) throws UnsupportedEncodingException {
        // TODO Auto-generated method stub

        // 암호화/복호화에 사용될 key 생성
        EgovPasswordEncoder pe = new EgovPasswordEncoder();

        String str = pe.encryptPassword("hshi");
        System.out.println(str);
        System.out.println(pe.checkPassword("hshi", str));
    }
    
}