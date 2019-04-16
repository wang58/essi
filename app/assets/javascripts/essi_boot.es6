import ModalViewer from "modal_viewer"
import StructureManager from "structure_manager"
import Flash from "flash"
export default class Initializer {
  constructor() {
    this.modal_viewer = new ModalViewer
    this.structure_manager = new StructureManager
    this.flash = new Flash
  }
}
