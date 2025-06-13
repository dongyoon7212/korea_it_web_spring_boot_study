package com.koreait.spring_boot_study.service;

import com.koreait.spring_boot_study.dto.SignupReqDto;
import com.koreait.spring_boot_study.dto.SignupRespDto;
import com.koreait.spring_boot_study.repository.AuthRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private AuthRepository authRepository;

    public SignupRespDto signup(SignupReqDto signupReqDto) {
        if(signupReqDto.getEmail() == null || signupReqDto.getEmail().trim().isEmpty()){
            SignupRespDto signupRespDto = new SignupRespDto(
                    "failed", "이메일을 입력해주세요"
            );
            return signupRespDto;
        } else if (signupReqDto.getPassword() == null || signupReqDto.getPassword().trim().isEmpty()) {
            SignupRespDto signupRespDto = new SignupRespDto(
                    "failed", "비밀번호를 입력해주세요"
            );
            return signupRespDto;
        } else if (signupReqDto.getUsername() == null || signupReqDto.getUsername().trim().isEmpty()) {
            SignupRespDto signupRespDto = new SignupRespDto(
                    "failed", "사용자 이름을 입력해주세요"
            );
            return signupRespDto;
        }
    }

}
