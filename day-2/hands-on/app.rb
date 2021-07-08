require_relative 'exporter'

class Report
    def initialize(exporter)
        @exporter = exporter
    end

    def generate_monthly_report
        puts 'Generating monthly report'
        @exporter.export
    end
end

puts 'Gime me PDF report!!'

pdf_report = Report.new(PdfExporter.new)
pdf_report.generate_monthly_report


puts 'Gime me XLS report!!'

xls_report = Report.new(XlsExporter.new)
xls_report.generate_monthly_report