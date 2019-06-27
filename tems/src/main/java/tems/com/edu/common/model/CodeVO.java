package tems.com.edu.common.model;

public class CodeVO {

	private String codeID;
	private String codeName;

	public String getCodeID() {
		return codeID;
	}

	public void setCodeID(String codeID) {
		this.codeID = codeID;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	@Override
	public String toString() {
		return "CodeVO [codeID=" + codeID + ", codeName=" + codeName + "]";
	}

}
