<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<c:url var="addAction" value="/books/add" />

<html>
    <head>
        <meta charset="UTF-8">
        <title>Books manager</title>
    </head>
    <body bgcolor="#eeeeee">
        <table width="95%" align="center">
            <tr>
                <td width="170" valign="top">
                    <form:form action="${addAction}" commandName="book">
                        <b>
                            <c:if test="${!empty book.title}">Edit book<br></c:if>
                            <c:if test="${empty book.title}">Add new book<br></c:if>
                        </b>
                        <c:if test="${!empty book.title}">
                            ID:<br>
                            <form:input disabled="true" path="id"/>
                            <form:hidden path="id"/>
                        </c:if>
                        <br>Title:<br>
                        <form:input maxlength="100" placeholder="Book title" path="title"/>
                        <form:errors path="title" cssClass="error" />
                        <br>Description:<br>
                        <form:input maxlength="255" placeholder="Book description" path="description"/>
                        <br>Author:<br>
                        <form:input maxlength="100" readonly="${!empty book.title}" placeholder="Book author" path="author"/>
                        <br>ISBN:<br>
                        <form:input maxlength="20" placeholder="Book ISBN" path="isbn"/>
                        <br>Print year:<br>
                        <form:input  placeholder="Book print year" path="printYear"/>

                        <br>
                        <c:if test="${!empty book.title}">
                            <input class="btn" type="submit" value="Submit changes"/>
                        </c:if>
                        <c:if test="${empty book.title}">
                            <input class="btn" type="submit" value="Add book"/>
                        </c:if>
                    </form:form>
                    <form action="/">
                        <b>Search</b><br>
                        <select name="column">
                            <option value="title">Title</option>
                            <option value="description">Description</option>
                            <option value="author">Author</option>
                        </select>
                        <input class="field" type="text" placeholder="Min 3 symbols or Blank to reset" name="field" />
                        <br>
                        <input class="btn" type="submit" value="Search" />
                    </form>
                </td>
                <td valign="top">
                    <c:if test="${!empty listBooks}">
                        <table align="center" width="100%">
                            <tr>
                                <th width=5%>ID</th>
                                <th width=15%>Book title</th>
                                <th width=35%>Description</th>
                                <th width=15%>Author</th>
                                <th width=10%>ISBN</th>
                                <th width=5%>Print Year</th>
                                <th width=5%>Read already</th>
                                <th width=5%>Edit</th>
                                <th width=5%>Read</th>
                                <th width=5%>Remove</th>
                            </tr>

                            <c:forEach items="${listBooks}" var="book">
                                <tr>
                                    <td align="center">${book.id}</td>
                                    <td align="center">${book.title}</td>
                                    <td align="center">${book.description}</td>
                                    <td align="center">${book.author}</td>
                                    <td align="center">${book.isbn}</td>
                                    <td align="center">${book.printYear}</td>
                                    <td align="center">
                                        <c:if test="${book.readAlready}">+</c:if>
                                        <c:if test="${!book.readAlready}">-</c:if>
                                    </td>
                                    <td align="center"><a href="<c:url value='/edit/${book.id}'/>"><img src="/resources/img/edit.png"></a></td>
                                    <td align="center">
                                        <c:if test="${!book.readAlready}">
                                            <a href="<c:url value='/read/${book.id}'/>"><img src="resources/img/v.png"></a>
                                        </c:if>
                                    </td>
                                    <td align="center"><a href="<c:url value='/remove/${book.id}'/>"><img src="/resources/img/close.png"></a></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:if>

                    <table align="center">
                        <tr>
                            <td>
                                <c:if test="${empty listBooks}">List of books is empty</c:if>

                                <c:url value="/" var="prev">
                                    <c:param name="page" value="${page-1}"/>
                                </c:url>
                                <c:if test="${page > 1}">
                                    <a href="<c:out value="${prev}" />" class="link">Previous</a>
                                </c:if>

                                <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                                    <c:choose>
                                        <c:when test="${page == i.index}">
                                            <span>${i.index}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/" var="url">
                                                <c:param name="page" value="${i.index}"/>
                                            </c:url>
                                            <a href='<c:out value="${url}" />'>${i.index}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:url value="/" var="next">
                                    <c:param name="page" value="${page + 1}"/>
                                </c:url>
                                <c:if test="${page + 1 <= maxPages}">
                                    <a href='<c:out value="${next}" />'>Next</a>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
