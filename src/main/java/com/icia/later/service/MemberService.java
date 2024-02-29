package com.icia.later.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.swing.text.View;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.later.dao.MemberDao;
import com.icia.later.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberService {
	@Autowired
	private MemberDao mDao;
	
	public String mEmailCheck(String memberEmailCheck) {
		log.info("memberEmailCheck()");
		int cnt = mDao.checkDuplicateId(memberEmailCheck);

		String res = null;
		if (cnt > 0) {
			// 아이디 있음
			res = "fail";
		} else {
			// 아이디 없음
			res = "ok";
		}

		return res;
	}
	
	public String insertMember(List<MultipartFile> files, MemberDto member, HttpSession session,
			RedirectAttributes rttr) {
		log.info("insertMember()");
		String msg = null; // DB에 저장 성공/실패 관련 메세지 저장
		String view = null;// 대상 페이지 지정 변수
		String upFile = files.get(0).getOriginalFilename();
		// 업로드하는 파일의 이름을 추출.

		try {
			if (!upFile.equals("")) {
				FileUpload(files, session, member);
			}
			mDao.insertMember(member);
			view = "redirect:/";
			msg = "가입 성공";
		} catch (Exception e) {// 저장 실패인 경우
			e.printStackTrace();
			view = "redirect:/";
			msg = "가입 실패";
		}
		rttr.addFlashAttribute("msg", msg);

		return view;
	}

	private void FileUpload(List<MultipartFile> files, HttpSession session, MemberDto member) throws Exception {
		log.info("fileUpload()");

		String sysname = null;// 변경하는 파일명
		String oriname = null;// 원래 파일명

		String realPath = session.getServletContext().getRealPath("/");
		log.info(realPath);
		realPath += "resources/upload/";
		File folder = new File(realPath);
//isDirectory() : 해당 이름이 폴더가 아니거나 존재하지않으면 false
		if (folder.isDirectory() == false) {
			folder.mkdir();// 폴더생성 메소드
		}

		MultipartFile mf = files.get(0);
		oriname = mf.getOriginalFilename();

		sysname = System.currentTimeMillis() + oriname.substring(oriname.lastIndexOf("."));

		File file = new File(realPath + sysname);

		mf.transferTo(file); // 하드디스크(경로상의 폴더)에 저장
		member.setMemberProfile(sysname);
	}

	// 일반회원 로그인기능
	public String mLogin(MemberDto member, HttpSession session, RedirectAttributes rttr) {
		log.info("mLogin()");
		String msg = null;
		String view = null;
		MemberDto loggedInMember = mDao.login(member);
		System.out.println(loggedInMember);
		
		if (loggedInMember != null) {
			msg = "로그인 성공";
			view = "redirect:/";

			System.out.println(loggedInMember);
			// 로그인시 세션에 저장
			session.setAttribute("mLogin", loggedInMember);
			System.out.println(loggedInMember);

		} else {
			msg = "이메일 및 비밀번호를 다시 확인해주세요.";
			view = "redirect:mLogin";
		}

		rttr.addFlashAttribute("msg", msg);
		System.out.println(msg);

		return view;
	}

	// 로그아웃 처리
		public String logout(HttpSession session, RedirectAttributes rttr) {
			log.info("logout()");
			String msg = "로그아웃 성공";

			session.removeAttribute("mLogin");

			rttr.addFlashAttribute("msg", msg);
			return "redirect:/";
		}

	// 상세보기 처리 메소드
	public void getMember(Integer memberId, Model model, HttpSession session) {
		log.info("getMember()");
		// DB에서 데이터 가져오기
		session.setAttribute("", session);
		MemberDto member = mDao.selectMember(memberId);
		// model에 담기
		model.addAttribute("member", member);
	}

	// 회원정보 수정 처리
	public String memberUpdate(List<MultipartFile> files, MemberDto member, HttpSession session,
			RedirectAttributes rttr) {
		log.info("memberUpdate()");
		String msg = null;
		String view = null;
		String poster = member.getMemberProfile();// 기존파일(포스터)
		
		try {
			if (!files.get(0).isEmpty()) {
				FileUpload(files, session, member);

				// 기존파일 삭제
				if (poster != null) {
					mFileDelete(poster, session);
				}
			}
			mDao.updateMember(member);
			System.out.println("mServ" + member);

			view = "redirect:/"; 
			msg = "수정 성공";
			// 기존 파일 삭제
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:/";
			msg = "수정 실패";
		}

		rttr.addFlashAttribute("msg", msg);
		return view;
	}

	// 기존 업로드이미지 삭제 처리 메서드
	private void mFileDelete(String poster, HttpSession session) throws Exception {
		log.info("fileDelete()");

		String realPath = session.getServletContext().getRealPath("/");
		realPath += "resouces/upload/" + poster;
		File file = new File(realPath);
		if (file.exists()) {
			file.delete();
		}

	}
	// 회원 탈퇴 메서드
	public String mDelete(Integer memberId, HttpSession session, RedirectAttributes rttr) {
		log.info("mDelete()");
		String msg = null;
		String view = null;
		MemberDto loginInfo = (MemberDto) session.getAttribute("mLogin");
		int id = loginInfo.getMemberId();

		try {
			if (loginInfo != null) {
				mDao.deleteMember(id);
				System.out.println("mServ" + id);

				view = "redirect:/"; // + member.getMemberId();
				msg = "탈퇴 성공";
			}

			// 기존 파일 삭제
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:/";// + member.getMemberId();
			msg = "탈퇴 실패";
		}

		rttr.addFlashAttribute("msg", msg);
		return view;

	}

	// 일반회원 이메일찾기
	public String mFindById(MemberDto member, Model model, RedirectAttributes rttr) {
	    log.info("mFindById()");
	    System.out.println(member);
	    String msg = null;
	    MemberDto EmailResult = mDao.FindById(member);
	    System.out.println(EmailResult);
	    
	    if(EmailResult == null) {
	        msg = "가입된 정보가 없습니다 다시 확인해주세요.";
	        rttr.addFlashAttribute("msg", msg);
	        return "redirect:/mFindById";
	    } else {
	        model.addAttribute("EmailResult", EmailResult);
	        return "mFindById";
	    }
	}
	
	// 일반회원 비밀번호찾기
		public String mFindByPass(MemberDto member, Model model, RedirectAttributes rttr) {
		    log.info("mFindByPass()");
		    System.out.println(member);
		    String msg = null;
		    MemberDto PassResult = mDao.FindByPass(member);
		    System.out.println(PassResult);
		    
		    if(PassResult == null) {
		        msg = "가입된 정보가 없습니다 다시 확인해주세요.";
		        rttr.addFlashAttribute("msg", msg);
		        return "redirect:/mFindByPass";
		    } else {
		        model.addAttribute("PassResult", PassResult);
		        return "mPassUpdate";
		    }
		}
		
		//일반회원 비밀번호 처리 메서드
		public String mUpdatePassProc(MemberDto member,RedirectAttributes rttr) {
			log.info("mUpdatePassProc()");
			System.out.println(member);
			String msg = null;
			String view = null;
			mDao.mUpdatePassProc(member);
			
			
			msg = "수정이 완료되었습니다 로그인 후 이용해주세요";
			view = "redirect:/mLogin";
			rttr.addFlashAttribute("msg", msg);
			
			return view;
		}

}