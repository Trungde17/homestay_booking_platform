<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="DAO.HomestayDAO"%>
<%@page import="DAO.HomestayTypeDAO"%>
<%@page import="DAO.DistrictDAO"%>
<%@page import="DAO.HomestayFacilitiesDAO"%>
<%@page import="DAO.NeighbourhoodDAO"%>
<%@page import="DAO.RuleDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Homestay</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/infor.css" />
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/menu.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block sidebar">
                    <jsp:include page="menu.jsp" />
                </nav>
                <div class="col-md-9 ml-sm-auto col-lg-10 content">
                    <c:set var="homestay" value="${sessionScope.homestay}"/>
                    <h2 class="mb-4">Edit Homestay</h2>

                    <!-- Homestay Name and Type -->
                    <div class="form-section">
                        <h4>Basic Information</h4>
                        <div>
                            <div class="form-row">
                                <form action="${pageContext.request.contextPath}/edithomestay?action=name" method="POST" class="form-group col-md-6">
                                    <label for="homestayName">Name</label>
                                    <input name="ht_name" type="text" class="form-control" id="homestayName" placeholder="Enter Homestay Name" value="${homestay.ht_name}">
                                    <button type="submit" class="btn btn-primary mt-2">Save</button>
                                </form>
                                <c:set var="type_list" value="${HomestayTypeDAO.getAll()}"/>
                                <form action="${pageContext.request.contextPath}/edithomestay?action=type" method="post" class="form-group col-md-6">
                                    <label for="homestayType">Type</label>
                                    <select name="ht_type" class="form-control" id="homestayType">
                                        <c:forEach var="type" items="${type_list}">
                                            <option value="${type.homestay_type_id}" 
                                                    ${type.homestay_type_id == homestay.homestayType.homestay_type_id ? 'selected' : ''}>
                                                ${type.homestay_type_name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit" class="btn btn-primary mt-2">Save</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Homestay Description -->
                    <div class="form-section">
                        <h4>Description</h4>
                        <form action="${pageContext.request.contextPath}/edithomestay?action=description" method="POST">
                            <div class="form-group">
                                <label for="homestayDescription">Description</label>
                                <textarea name="ht_description" class="form-control" id="homestayDescription" rows="5" placeholder="Enter Homestay Description">${homestay.describe}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form>
                    </div>
                    <!-- Homestay Address and District -->
                    <div class="form-section">
                        <h4>Address</h4>
                        <form action="${pageContext.request.contextPath}/edithomestay?action=address" method="POST" class="form-row">
                            <div class="form-group col-md-6">
                                <label for="homestayAddress">Detailed Address</label>
                                <input name="address_detail" type="text" class="form-control" id="homestayAddress" placeholder="Enter Address" value="${homestay.address_detail}">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="district">District</label>
                                <c:set var="districts" value="${DistrictDAO.getAll()}"/>
                                <select name="district_id" class="form-control" id="district">
                                    <c:forEach var="district" items="${districts}">
                                        <option value="${district.district_id}"
                                                ${homestay.district.district_id == district.district_id ? 'selected' : ''}>${district.district_name}</option>
                                    </c:forEach>
                                </select>                                  
                            </div>
                            <button type="submit" class="btn btn-primary mt-2">Save</button>
                        </form>
                    </div>

                    <!-- Facilities -->
                    <div class="form-section">
                        <c:set var="fa_list" value="${HomestayFacilitiesDAO.getAll()}"/>
                        <h4>Facilities</h4>
                        <form action="${pageContext.request.contextPath}/edithomestay?action=facilities" method="POST">
                            <div class="row">
                                <c:forEach var="fa" items="${fa_list}" varStatus="status">
                                    <div class="form-check col-md-3">
                                        <input class="form-check-input" type="checkbox" id="facility${fa.facilities_id}" name="facilities" value="${fa.facilities_id}"
                                               ${homestay.checkFacilities(fa.facilities_id) ? 'checked' : ''}>
                                        <label class="form-check-label" for="facility${fa.facilities_id}">${fa.facilities_name}</label>
                                    </div>
                                </c:forEach>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Save</button>
                        </form>
                    </div>

                    <!-- Neighbourhood -->
                    <div class="form-section">
                        <h4>Neighbourhood</h4>
                        <c:set var="neighbourhoods" value="${NeighbourhoodDAO.getAll()}"/>
                        <form action="${pageContext.request.contextPath}/edithomestay?action=neighbourhoods" method="POST">
                            <div class="row">
                                <c:forEach var="neighbourhood" items="${neighbourhoods}" varStatus="status">
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="neighbourhood${neighbourhood.neighbourhood_id}" name="neighbourhoods" value="${neighbourhood.neighbourhood_id}"
                                                   ${homestay.checkNeighbourhood(neighbourhood.neighbourhood_id) ? 'checked' : ''}>
                                            <label class="form-check-label" for="neighbourhood${neighbourhood.neighbourhood_id}">${neighbourhood.neighbourhood_name}</label>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Save</button>
                        </form>
                    </div>

                    <!-- Rules -->
                    <div class="form-section">
                        <h4>Rules</h4>
                        <form action="${pageContext.request.contextPath}/edithomestay?action=rules" method="POST">
                            <c:set var="rules" value="${RuleDAO.getAll()}"/>
                            <div class="mb-3">
                                <h5>Common Rules</h5>
                                <div class="row">
                                    <c:forEach var="rule" items="${rules}" varStatus="status">
                                        <div class="col-md-2">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="rule${rule.rule_id}" name="rule_common" value="${rule.rule_id}"
                                                       ${homestay.checkRule(rule.rule_id) ? 'checked' : ''}>
                                                <label class="form-check-label" for="rule${rule.rule_id}">${rule.rule_name}</label>
                                            </div>
                                        </div>
                                        <c:if test="${status.count % 5 == 0}">
                                        </div><div class="row">
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div>
                                <h5>Custom Rules</h5>
                                <textarea name="ht_rules" class="form-control" rows="4" placeholder="Enter custom rules here">${homestay.homestay_rules}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Save</button>
                        </form>
                    </div>
                    <!-- Homestay Status -->
                    <!-- Homestay Status -->
                    <div class="form-section">
                        <h4>Status</h4>
                        <form action="${pageContext.request.contextPath}/edithomestay?action=status" method="POST" class="d-flex align-items-center">
                            <input type="hidden" name="ht_status" value="0">
                            <input type="checkbox" name="ht_status" value="1" ${homestay.status == 1 ? 'checked' : ''} data-toggle="toggle" data-on="Active" data-off="Inactive" data-onstyle="success" data-offstyle="danger">
                            <button type="submit" class="btn btn-primary ml-2">Save</button>
                        </form>
                    </div>


                    <!-- Homestay Images -->
                    <div class="form-section">
                        <h4>Images</h4>
                        <c:set var="imgs" value="${homestay.img}"/>
                        <div class="row">
                            <c:forEach var="img" items="${imgs}" varStatus="status">
                                <div class="col-md-4 mb-3">
                                    <form action="${pageContext.request.contextPath}/edithomestay?action=img" method="POST" enctype="multipart/form-data">
                                        <div class="image-square" onclick="document.getElementById('image${status.index}').click()">
                                            <input type="hidden" name="img_id" value="${img.img_id}">
                                            <img src="${img.img_url}" alt="Homestay Image ${status.index}" id="img${status.index}" data-id="${status.index}" data-url="${img.img_url}">
                                            <input name="img_file" type="file" id="image${status.index}" accept="image/*" onchange="handleImageChange(event, 'img${status.index}')" required>
                                            <button type="button" class="remove-image" onclick="removeImage(event, 'img${status.index}', 'image${status.index}')">&times;</button>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </form>
                                </div>
                                <c:if test="${status.index % 3 == 2}">
                                </div><div class="row">
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>



                </div>
            </div>
        </div>
        <script>
            function handleImageChange(event, imgId) {
                const input = event.target;
                const reader = new FileReader();
                reader.onload = function () {
                    const img = document.getElementById(imgId);
                    img.src = reader.result;
                };
                reader.readAsDataURL(input.files[0]);
            }

            function removeImage(event, imgId, inputId) {
                event.stopPropagation(); // Prevent the parent click event
                document.getElementById(imgId).src = '';
                document.getElementById(inputId).value = '';
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    </body>
</html>
