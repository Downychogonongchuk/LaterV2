package com.icia.later;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.later.dto.BoardDto;
import com.icia.later.dto.CustomerDto;
import com.icia.later.dto.MemberDto;
import com.icia.later.service.BoardService;
import com.icia.later.service.MemberService;
import com.icia.later.service.ReservationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CompanyController {

	@Autowired
	private MemberService mServ;
	@Autowired
	private BoardService bServ;
	@Autowired
	private ReservationService rServ;

	// ��ü ��������
	@GetMapping("companyDetail")
	public String companyDetail(Integer boardId, Model model, HttpSession session) {
		log.info("companyDetail()");
		MemberDto mLogInInfo = (MemberDto) session.getAttribute("mLogin");
		// �α����� ����� ȸ�� ����(2024-02-26)
		CustomerDto cLogInInfo = (CustomerDto) session.getAttribute("cLogin");
	    // �α����� ȸ�� ������ �𵨿� �߰��Ͽ� JSP�� ����
	    model.addAttribute("mLogInInfo", mLogInInfo);
	    // �α����� ����� ������ �𵨿� �߰��Ͽ� JSP�� ����
	    model.addAttribute("cLogInInfo", cLogInInfo);
		
		bServ.getCompanyDetail(boardId, model);
		System.out.println(model);
	
		return "companyDetail";
	}

	// ���� ��û�� ���������� �̵�
			@GetMapping("applyCompany")
			
			public String applyCompany(Integer pageNum, 
										Model model,
										HttpSession session,
										Integer memberId1 ) {		
				log.info("applyCompany()");
				
			    Object someValue = session.getAttribute("mLogin");

			    if (someValue instanceof MemberDto) {
			        MemberDto memberDto = (MemberDto) someValue;

			        Integer memberId11 = memberDto.getMemberId();
			        
					 String view = rServ.getBoardListBymemberId(pageNum, 
							 model,
							 session, 
							 memberId11);
					    return view;
				} else{
					
			        return "redirect:/mlogin"; // �α��� �������� �����̷�Ʈ ����
					
					}
				}
	
			// ������ ������ �̵�
						@GetMapping("companyList")
						
						public String companyList(Integer pageNum, 
													Model model,
													HttpSession session,
													Integer customerId1 ) {		
							log.info("companyList()");
							
						    Object someValue = session.getAttribute("cLogin");

						    if (someValue instanceof CustomerDto) {
						    	CustomerDto customerDto = (CustomerDto) someValue;

						        Integer customerId = customerDto.getCustomerId();
						        
								 String view = bServ.getBoardListBycustomerId(pageNum, 
										 model,
										 session, 
										 customerId);
								    return view;
							} else{
								
						        return "redirect:/clogin"; // �α��� �������� �����̷�Ʈ ����
								
								}
							}
						
						// ��ü�� ��û�� ȸ���� �����ִ� ������ // �� ��ü�� ��û�� �����
						@GetMapping("selectApply")
						public String selectApply(Model model,Integer memberId, Integer boardId, HttpSession session) {
							log.info("selectApply()");
							
							List<ReservationDto> rList = rServ.getReservationList(boardId);
							
							System.out.println(rList);
							
							
							MemberDto mLogInInfo = (MemberDto) session.getAttribute("mLogin");
							// �α����� ����� ȸ�� ����(2024-02-26)
							CustomerDto cLogInInfo = (CustomerDto) session.getAttribute("cLogin");
						    // �α����� ȸ�� ������ �𵨿� �߰��Ͽ� JSP�� ����
						    model.addAttribute("mLogInInfo", mLogInInfo);
						    // �α����� ����� ������ �𵨿� �߰��Ͽ� JSP�� ����
						    model.addAttribute("cLogInInfo", cLogInInfo);
							model.addAttribute("rList", rList);
							
							
							return "selectApply";
						}

						// ���� ���� status
						@PostMapping("select")
						public String select(Integer reservationId, String status, Model model, RedirectAttributes rttr) {
							log.info("select()");
							
							String view = rServ.updateStatus(reservationId, status, model, rttr);
							
							return view;
						}
			
		}

	  
	
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			


