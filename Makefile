# New ports collection makefile for:	review
# Date created:		2011-03-30
# Whom:			TAKATSU Tomonari <tota@FreeBSD.org>
#
# $FreeBSD$
#

PORTNAME=	review
PORTVERSION=	0.9.0
CATEGORIES=	textproc ruby
#MASTER_SITES=	https://download.github.com/ \
#		${MASTER_SITE_LOCAL:S|%SUBDIR%|tota/review|}
MASTER_SITES=	${MASTER_SITE_LOCAL:S|%SUBDIR%|tota/review|}
DISTNAME=	kmuto-${PORTNAME}-v${PORTVERSION}-0-g${GITVERSION}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	ReVIEW is flexible document format/conversion system

GITVERSION=	f57874b
#FETCH_ARGS=	-pRr
WRKSRC=	${WRKDIR}/kmuto-${PORTNAME}-${GITVERSION}

LICENSE=	LGPL21
LICENSE_FILE=	${WRKSRC}/COPYING

USE_RUBY=	yes
NO_BUILD=	yes

RUBY_SHEBANG_FILES=	bin/*
PORTDOCS=	*
PORTEXAMPLES=	sample.*

post-patch:
	@${MV} ${WRKSRC}/doc/${PORTEXAMPLES} ${WRKSRC}

do-install:
	@${INSTALL_SCRIPT} ${INSTALL_WRKSRC}/bin/* ${PREFIX}/bin/
.if !defined(NOPORTDOCS)
	@${MKDIR} ${DOCSDIR}
	@cd ${INSTALL_WRKSRC}/doc; ${COPYTREE_SHARE} . ${DOCSDIR}
.endif
.if !defined(NOPORTEXAMPLES)
	@${MKDIR} ${EXAMPLESDIR}
	@cd ${INSTALL_WRKSRC}; ${INSTALL_DATA} ${PORTEXAMPLES} ${EXAMPLESDIR}
.endif

.include <bsd.port.mk>
