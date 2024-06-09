
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.RuleDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rules - My Homestay</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/register/homestay_register.css" />  
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/register/header.css" /> 
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/main.css" />

    </head>
    <body>
        <%@include file="header.jsp"%>
        <div class="container">
            <div class="listing-setup mx-auto">
                <div class="header">Rules</div>
                <div class="progress-indicator">
                    <div class="step">
                        <div class="icon"><i class="fas fa-home"></i></div>
                        <p>Home</p>
                    </div>
                    <div class="step">
                        <div class="icon"><i class="fas fa-map-marker-alt"></i></div>
                        <p>Location</p>
                    </div>
                    <div class="step ">
                        <div class="icon"><i class="fas fa-bed"></i></div>
                        <p>Rooms</p>
                    </div>
                    <div class="step active">
                        <div class="icon"><i class="fas fa-book"></i></div>
                        <p>Rules</p>
                    </div>
                    <div class="step">
                        <div class="icon"><i class="fas fa-user"></i></div>
                        <p>Host</p>
                    </div>
                    <div class="step">
                        <div class="icon"><i class="fas fa-images"></i></div>
                        <p>Photos</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="listing-setup mx-auto">
                        <form action="${pageContext.request.contextPath}/register_step4_controller" method="POST">

                            <div class="form-group">
                                <label for="homestayRules">Your Homestay Rules</label>
                                <textarea name="ht_rules" class="form-control" id="homestayRules" rows="4" minlength="100" required></textarea>
                            </div>
                            <div class="mt-5 mb-5">
                                <c:set var="common_rule_list" value="${RuleDAO.getAll()}"/>
                                <c:forEach var="common_rule" items="${common_rule_list}">
                                    <div class="col-md-6 mt-3">                                        
                                        <div class="form-check">
                                            <input name="common_rules" class="form-check-input" type="checkbox" id="${common_rule.getRule_id()}" name="facility" value="${common_rule.getRule_id()}">
                                            <label class="form-check-label font-weight-bold" for="${common_rule.getRule_id()}">${common_rule.getRule_name()}</label>
                                        </div>                                               
                                    </div>
                                </c:forEach>
                            </div>
                                <c:set var="fail_rq" value="${requestScope.fail_request}"/>
                                <p class="error">${fail_rq}</p>
                            <button type="submit" class="btn btn-primary btn-block mt-4">Continue</button>                           
                        </form>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="sidebar">
                        <div class="info-box">
                            <h6>CASH OR TRANSFER?</h6>
                            <p>Guests usually pay cash on arrival. If you require payment in advance please state how you wish to be paid i.e. by bank transfer or Paypal. If you are collecting payment in advance please also state your cancellation policy.</p>
                        </div>
                        <div class="info-box">
                            <h6>DO'S AND DON'TS</h6>
                            <p>It's a good idea to list out some general do's and don'ts for guests so that they have an idea of what to expect before booking.</p>
                        </div>
                        <div class="mt-3">
                            <p>QUESTION? GET IN TOUCH:</p>
                            <p>Email us at <a href="mailto:hostsupport@homestay.com">hostsupport@homestay.com</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

