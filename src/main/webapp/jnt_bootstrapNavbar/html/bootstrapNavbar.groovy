import org.apache.taglibs.standard.functions.Functions
import org.jahia.services.content.JCRContentUtils
import org.jahia.services.render.RenderService
import org.jahia.services.render.Resource
import org.jahia.taglibs.jcr.node.JCRTagUtils

menuType = currentNode.properties['menuType'];
depthRaw = currentNode.properties['depth'];
startLevelRaw = currentNode.properties['startLevel'];
title = currentNode.properties['jcr:title']

startLevel = startLevelRaw ? startLevelRaw.long : 0;
depth = depthRaw ? depthRaw.long : 0

def base;

if (startLevel == -1) {
    base = JCRTagUtils.getMeAndParentsOfType(renderContext.mainResource.node, "jnt:page")[0];
    startLevel = 0
} else {
    base = currentNode.resolveSite.home
}

if (!base) {
    base = renderContext.mainResource.node
}

def empty = true
def printMenu;

printMenu = { node, currentLevel ->

    firstEntry = true;

    if (node) {
        children = JCRContentUtils.getChildrenOfType(node, "jmix:navMenuItem");
        def nbOfChilds = children.size();
        def isListOpen = false;
        //print "size is " + children.size();
        children.each() { menuItem ->
            itemPath = menuItem.path
            correctType = true
            if (menuItem.isNodeType("jmix:navMenu")) {
                correctType = false
            }
            if (menuItem.properties['j:displayInMenu']) {
                correctType = false
                menuItem.properties['j:displayInMenu'].each() {
                    correctType |= (it.node.identifier == currentNode.identifier)
                }
            }
            if ((depth >= currentLevel) && correctType) {
                Resource resource = new Resource(menuItem, "html", "menuElement", currentResource.getContextConfiguration());
                def render = RenderService.getInstance().render(resource, renderContext)
                if (render != "") {

                    if (firstEntry) {
                        if (currentLevel == 1) {
                            print "\n" +
                                    "    <div class=\"navbar\">\n" +
                                    "        <div class=\"navbar-inner\">"
                            if (title) {
                                    print "<a class=\"brand\" href=\"#\">${Functions.escapeXml(title.string)}</a>";
                            }
                            print "<ul class=\"nav\">"
                        } else {
                            print "<ul class=\"dropdown-menu\">"
                        }
                        isListOpen = true;
                        empty = false;
                    }

                    selected = menuItem.isNodeType("jmix:nodeReference") ?
                        renderContext.mainResource.node.path == menuItem.properties['j:node'].node.path :
                        renderContext.mainResource.node.path == itemPath
                    inpath = renderContext.mainResource.node.path == itemPath || renderContext.mainResource.node.path.startsWith(itemPath)
                    hasChildren = JCRTagUtils.hasChildrenOfType(menuItem, "jnt:page,jnt:nodeLink,jnt:externalLink")

                    listItemCssClass = (inpath || selected ? " active" : "") + (hasChildren ? " dropdown" : "");

                    print "<li class=\"${listItemCssClass}\">"
                    print render
                    if (hasChildren) {
                        print "<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"><b class=\"caret\"></b></a>";
                        printMenu(menuItem, currentLevel + 1);
                    }
                    print "</li>"
                    firstEntry = false;
                }
            }
        }
        if (isListOpen && ! empty) {
            print("</ul>");
            if (currentLevel == 1) {
                print "        </div>\n" +
                        "    </div>"
            }
            isListOpen = false;
        }
    }

    if (empty && renderContext.editMode) {
        print " <div class=\"alert alert-info\">\n" +
                "                <button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button>\n" +
                "                <strong>Heads up!</strong> Navigation bar is empty" +
                "            </div>"
        empty = false;
    }
}
printMenu(base, 1)

