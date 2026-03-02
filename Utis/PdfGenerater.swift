import UIKit

extension UIView {
    /// Generates a PDF from the UIView and returns it as Data
    func generatePDF() -> Data? {
        let pdfPageFrame = self.bounds
        let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: pdfContext)
        
        UIGraphicsEndPDFContext()
        return pdfData as Data
    }
}

class PDFGenerator {
    /// Generates a PDF from a UITableViewCell and saves it to the Documents Directory
    static func generatePDFFromCell(_ cell: UITableViewCell, fileName: String = "TableViewCellDesign.pdf") -> URL? {
        cell.layoutIfNeeded()
        
        if let pdfData = cell.contentView.generatePDF() {
            let pdfURL = getDocumentsDirectory().appendingPathComponent(fileName)
            
            do {
                try pdfData.write(to: pdfURL)
                print("PDF saved at: \(pdfURL)")
                return pdfURL
            } catch {
                print("Error saving PDF: \(error)")
            }
        }
        return nil
    }
    
    /// Helper function to get the Documents Directory path
    private static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
