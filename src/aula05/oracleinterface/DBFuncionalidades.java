/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package aula05.oracleinterface;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JComboBox;
import javax.swing.JTable;
import javax.swing.JTextArea;
import java.sql.ResultSetMetaData;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Locale;


/**
 *
 * @author junio
 */
public class DBFuncionalidades {
    Connection connection;
    Statement stmt;
    ResultSet rs;
    JTextArea jtAreaDeStatus;
    
    public DBFuncionalidades(JTextArea jtaTextArea){
        jtAreaDeStatus = jtaTextArea;
    }
    
    public boolean conectar(String username, String password){       
    try {
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        connection = DriverManager.getConnection(
                "jdbc:oracle:thin:@orclgrad2.icmc.usp.br:1521/pdb_junior.icmc.usp.br",
                username,
                password);
        return true;
    } catch(SQLException ex){
        jtAreaDeStatus.setText("Problema: verifique seu usuário e senha");
    }
    return false;
}
    public void pegarNomesDeTabelas(JComboBox jc){
        String s = "";
        try {
            s = "SELECT table_name FROM user_tables";
            stmt = connection.createStatement();
            rs = stmt.executeQuery(s);
            while (rs.next())
                jc.addItem(rs.getString("table_name"));         
            stmt.close();
        } catch (SQLException ex) {
            jtAreaDeStatus.setText("Erro na consulta: \"" + s + "\"");
        }        
    }
   public void exibeDados(JTable tATable, String sTableName) {
    String query = "SELECT * FROM " + sTableName;
    
    try {
        // Criando um Statement rolável
        stmt = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery(query);
        ResultSetMetaData rsmd = rs.getMetaData();
        
        // Obtém o número de colunas
        int columnCount = rsmd.getColumnCount();
        String[] columnNames = new String[columnCount];
        
        for (int i = 1; i <= columnCount; i++) {
            columnNames[i - 1] = rsmd.getColumnName(i);
        }

        // Use rs.last() agora que o ResultSet é rolável
        rs.last();
        int rowCount = rs.getRow();
        rs.beforeFirst(); // Volta para o início do ResultSet

        String[][] data = new String[rowCount][columnCount];
        int rowIndex = 0;
        while (rs.next()) {
            for (int colIndex = 1; colIndex <= columnCount; colIndex++) {
                data[rowIndex][colIndex - 1] = rs.getString(colIndex);
            }
            rowIndex++;
        }

        tATable.setModel(new javax.swing.table.DefaultTableModel(data, columnNames));
        
        stmt.close();
    } catch (SQLException ex) {
        jtAreaDeStatus.setText(ex.getMessage());
    }
}



public void preencheDadosDeTabela(JTextArea jtext, String sUmaTabela) {
    String query = "SELECT COLUMN_ID, COLUMN_NAME, DATA_TYPE, DATA_LENGTH, NULLABLE " +
             "FROM USER_TAB_COLUMNS " +
             "WHERE UPPER(table_name)='" + sUmaTabela.toUpperCase() + "'";
    try {
        stmt = connection.createStatement();

        rs = stmt.executeQuery(query);
        jtAreaDeStatus.setText("");
        while (rs.next()) {
            jtAreaDeStatus.append(rs.getString("COLUMN_ID") + "." +
                    rs.getString("COLUMN_NAME") + " " +
                    rs.getString("DATA_TYPE") + "(" +
                    rs.getString("DATA_LENGTH")+ ") NULLABLE: " +
                    rs.getString("NULLABLE") + ", " );
        }

        stmt.close();
    } catch(SQLException ex) {
        jtAreaDeStatus.setText(ex.getMessage());

    }

}

public void exportaTabelaParaCSV(JTable table, String nomeArquivo) throws IOException {
    FileWriter csvWriter = new FileWriter(nomeArquivo, StandardCharsets.UTF_8);

    // Escrever os cabeçalhos (nomes das colunas)
    for (int i = 0; i < table.getColumnCount(); i++) {
        csvWriter.append(table.getColumnName(i));
        if (i < table.getColumnCount() - 1) {
            csvWriter.append(";");
        }
    }
    csvWriter.append("\n");

    // Configurar o locale e formato de data
    Locale locale = Locale.getDefault();
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy", locale);  // Ajuste conforme o formato do Excel

    // Escrever os dados
    for (int i = 0; i < table.getRowCount(); i++) {
        for (int j = 0; j < table.getColumnCount(); j++) {
            Object value = table.getValueAt(i, j);
            if (value instanceof java.sql.Date) {
                // Formatar a data para o formato apropriado para o Excel
                value = dateFormat.format(value);
            }
            csvWriter.append(String.valueOf(value));
            if (j < table.getColumnCount() - 1) {
                csvWriter.append(";");
            }
        }
        csvWriter.append("\n");
    }

    csvWriter.flush();
    csvWriter.close();
}
    //public void preencheComboBoxComRestricoesDeCheck
    //public void preencheComboBoxComValoresReferenciados
    //
}
