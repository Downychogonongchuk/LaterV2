package com.icia.later.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.later.dao.CustomerDao;
import com.icia.later.dto.CustomerDto;
import com.icia.later.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CustomerService {
	@Autowired CustomerDao cDao;
	
	public String cEmailCheck(String customerEmailCheck) {
		log.info("customerEmailCheck()");
		int cnt = cDao.checkDuplicateId(customerEmailCheck);

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

	public String insertCustomer(List<MultipartFile> files,
									CustomerDto customer, 
									HttpSession session,
									RedirectAttributes rttr) {
		log.info("insertCustomer()");
		String msg = null; // DB에 저장 성공/실패 관련 메세지 저장
		String view = null;// 대상 페이지 지정 변수
		String upFile = files.get(0).getOriginalFilename();
		// 업로드하는 파일의 이름을 추출.

		try {
			if (!upFile.equals("")) {
				FileUpload(files, session, customer);
			}
			cDao.insertCustomer(customer);
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
	
	private void FileUpload(List<MultipartFile> files, HttpSession session, CustomerDto customer) throws Exception {
		log.info("cServ에 fileUpload()");

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
		customer.setCustomerProfile(sysname);
	}

	// 로그인기능
		public String cLogin(CustomerDto customer, HttpSession session, RedirectAttributes rttr) {
			log.info("login2()");
			String msg = null;
			String view = null;
			CustomerDto loggedInCustomer = cDao.login(customer);
			System.out.println(loggedInCustomer);
			
			if (loggedInCustomer != null) {
				msg = "로그인 성공";
				view = "redirect:/";

				System.out.println(loggedInCustomer);
				// 로그인시 세션에 저장
				session.setAttribute("cLogin", loggedInCustomer);
				System.out.println(loggedInCustomer);

			} else {
				msg = "이메일 및 비밀번호를 다시 확인해주세요.";
				view = "redirect:cLogin";
			}

			rttr.addFlashAttribute("msg", msg);
			System.out.println(msg);

			return view;
		}
	// 회원정보 수정 처리
		public String customerUpdate(List<MultipartFile> files, CustomerDto customer, HttpSession session,
				RedirectAttributes rttr) {
			log.info("customerUpdate()");
			String msg = null;
			String view = null;
			String poster = customer.getCustomerProfile();// 기존파일(포스터)
			
			try {
				if (!files.get(0).isEmpty()) {
					FileUpload(files, session, customer);

					// 기존파일 삭제
					if (poster != null) {
						cFileDelete(poster, session);
					}
				}
				cDao.updateCustomer(customer);
				System.out.println("cServ" + customer);

				view = "redirect:/"; // + member.getMemberId();
				msg = "수정 성공";
				// 기존 파일 삭제
			} catch (Exception e) {
				e.printStackTrace();
				view = "redirect:mUpdate?memberId=" + customer.getCustomerId();
				msg = "수정 실패";
			}

			rttr.addFlashAttribute("msg", msg);
			return view;
		}
		
		// 기존 업로드이미지 삭제 처리 메서드
		private void cFileDelete(String poster, HttpSession session) throws Exception {
			log.info("fileDelete()");

			String realPath = session.getServletContext().getRealPath("/");
			realPath += "resouces/upload/" + poster;
			File file = new File(realPath);
			if (file.exists()) {
				file.delete();
			}

		}

		// 회원 탈퇴 메서드
		public String cDelete(Integer customerId, HttpSession session, RedirectAttributes rttr) {
			log.info("cDelete()");
			String msg = null;
			String view = null;
			CustomerDto loginInfo = (CustomerDto) session.getAttribute("cLogin");
			int id = loginInfo.getCustomerId();

			try {
				if (loginInfo != null) {
					cDao.deleteCustomer(id);
					System.out.println("cServ" + id);

					view = "redirect:/"; 
					msg = "탈퇴 성공";
				}

				// 기존 파일 삭제
			} catch (Exception e) {
				e.printStackTrace();
				view = "redirect:/";
				msg = "탈퇴 실패";
			}

			rttr.addFlashAttribute("msg", msg);
			return view;

		}
		
		// 사업자회원 이메일찾기
		public String cFindById(CustomerDto customer, Model model, RedirectAttributes rttr) {
		    log.info("cFindById()");
		    System.out.println(customer);
		    String msg = null;
		    CustomerDto EmailResult = cDao.FindById(customer);
		    System.out.println(EmailResult);
		    
		    if(EmailResult == null) {
		        msg = "가입된 정보가 없습니다 다시 확인해주세요.";
		        rttr.addFlashAttribute("msg", msg);
		        return "redirect:/cFindById";
		    } else {
		        model.addAttribute("EmailResult", EmailResult);
		        return "cFindById";
		    }
		}
		
		// 사업자회원 비밀번호찾기
				public String cFindByPass(CustomerDto customer, Model model, RedirectAttributes rttr) {
				    log.info("cFindByPass()");
				    System.out.println(customer);
				    String msg = null;
				    CustomerDto PassResult = cDao.FindByPass(customer);
				    System.out.println(PassResult);
				    
				    if(PassResult == null) {
				        msg = "가입된 정보가 없습니다 다시 확인해주세요.";
				        rttr.addFlashAttribute("msg", msg);
				        return "redirect:/cFindByPass";
				    } else {
				        model.addAttribute("PassResult", PassResult);
				        return "cPassUpdate";
				    }
				}
				
				//사업자회원 비밀번호 처리 메서드
				public String cUpdatePassProc(CustomerDto customer,RedirectAttributes rttr) {
					log.info("cUpdatePassProc()");
					System.out.println(customer);
					String msg = null;
					String view = null;
					cDao.cUpdatePassProc(customer);
					
					
					msg = "수정이 완료되었습니다 로그인 후 이용해주세요";
					view = "redirect:/cLogin";
					rttr.addFlashAttribute("msg", msg);
					
					return view;
				}
}