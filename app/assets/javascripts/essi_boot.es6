import ModalViewer from "modal_viewer"
import StructureManager from "structure_manager"
export default class Initializer {
  constructor() {
    this.modal_viewer = new ModalViewer
    this.structure_manager = new StructureManager
  }
}
