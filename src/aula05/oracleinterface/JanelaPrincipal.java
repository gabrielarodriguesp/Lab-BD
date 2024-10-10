package aula05.oracleinterface;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JOptionPane;

/**
 *
 * @author junio
 */
public class JanelaPrincipal {

    JFrame j;
    JPanel pPainelDeCima;
    JPanel pPainelDeBaixo;
    JComboBox<String> jc;
    JTextArea jtAreaDeStatus;
    JTabbedPane tabbedPane;
    JPanel pPainelDeExibicaoDeDados;
    JTable jt;
    JPanel pPainelDeInsecaoDeDados;
    DBFuncionalidades bd;

    public void ExibeJanelaPrincipal(String username, String password) {
        /* Janela */
        j = new JFrame("ICMC-USP - SCC0641 - Pratica 5");
        j.setSize(700, 500);
        j.setLayout(new BorderLayout());
        j.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        /* Painel da parte superior (north) - com combobox e outras informações */
        pPainelDeCima = new JPanel();
        j.add(pPainelDeCima, BorderLayout.NORTH);
        jc = new JComboBox<>();
        pPainelDeCima.add(jc);

        /* Painel da parte inferior (south) - com área de status */
        pPainelDeBaixo = new JPanel();
        j.add(pPainelDeBaixo, BorderLayout.SOUTH);
        jtAreaDeStatus = new JTextArea();
        jtAreaDeStatus.setText("Aqui é sua área de status");
        pPainelDeBaixo.add(jtAreaDeStatus);
        JButton exportCsvButton = new JButton("Exporta CSV MSExcel");
        pPainelDeCima.add(exportCsvButton);


        /* Painel tabulado na parte central (CENTER) */
        tabbedPane = new JTabbedPane();
        j.add(tabbedPane, BorderLayout.CENTER);

        /* Tab de exibição */
        pPainelDeExibicaoDeDados = new JPanel();
        pPainelDeExibicaoDeDados.setLayout(new GridLayout(1, 1));
        tabbedPane.add(pPainelDeExibicaoDeDados, "Exibição");

        /* Table de exibição */
        jt = new JTable();
        JScrollPane jsp = new JScrollPane(jt);
        pPainelDeExibicaoDeDados.add(jsp);

        /* Tab de inserção */
        pPainelDeInsecaoDeDados = new JPanel();
        pPainelDeInsecaoDeDados.setLayout(new GridLayout(3, 2));
        pPainelDeInsecaoDeDados.add(new JLabel("Coluna1"));
        pPainelDeInsecaoDeDados.add(new JTextField("Digite aqui"));
        pPainelDeInsecaoDeDados.add(new JLabel("Coluna2"));
        pPainelDeInsecaoDeDados.add(new JTextField("Digite aqui"));
        pPainelDeInsecaoDeDados.add(new JLabel("Coluna3"));
        pPainelDeInsecaoDeDados.add(new JTextField("Digite aqui"));
        tabbedPane.add(pPainelDeInsecaoDeDados, "Inserção");

        j.setVisible(true);

        bd = new DBFuncionalidades(jtAreaDeStatus);
        if (bd.conectar(username, password)) {
            bd.pegarNomesDeTabelas(jc);
        }


        exportCsvButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    bd.exportaTabelaParaCSV(jt, "dados_exportados.csv");
                    JOptionPane.showMessageDialog(null, "Dados exportados com sucesso para CSV!");
                } catch (IOException ex) {
                    jtAreaDeStatus.setText("Erro ao exportar: " + ex.getMessage());
                }
            }
        });

        this.DefineEventos();
    }

    private void DefineEventos() {
        jc.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                JComboBox<String> jcTemp = (JComboBox<String>) e.getSource();
                String selectedTable = (String) jcTemp.getSelectedItem();
                bd.preencheDadosDeTabela(jtAreaDeStatus, selectedTable);
                bd.exibeDados(jt, selectedTable);
            }
        });
    }
}
