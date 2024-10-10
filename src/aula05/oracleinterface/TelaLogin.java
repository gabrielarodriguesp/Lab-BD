package aula05.oracleinterface;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TelaLogin {
    private JFrame frame;
    private JTextField usernameField;
    private JPasswordField passwordField;
    private JTextArea statusArea;

    public void exibeTelaLogin() {
        frame = new JFrame("Login");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new GridLayout(4, 2));

        // Adicionando campos de texto
        frame.add(new JLabel("Usuário:"));
        usernameField = new JTextField();
        frame.add(usernameField);

        frame.add(new JLabel("Senha:"));
        passwordField = new JPasswordField();
        frame.add(passwordField);

        // Adicionando área de status
        statusArea = new JTextArea();
        statusArea.setEditable(false);
        frame.add(statusArea);

        // Botão de login
        JButton loginButton = new JButton("Conectar");
        frame.add(loginButton);

        loginButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Passa as credenciais para a tela principal
                String username = usernameField.getText();
                String password = new String(passwordField.getPassword());
                if (connectToDatabase(username, password)) {
                    JanelaPrincipal j = new JanelaPrincipal();
                    j.ExibeJanelaPrincipal(username,password);  // Chama a tela principal
                    frame.dispose();  // Fecha a tela de login
                } else {
                    statusArea.setText("Falha na conexão. Verifique seu usuário e senha.");
                }
            }
        });

        frame.setVisible(true);
    }

    private boolean connectToDatabase(String username, String password) {
        // Aqui você pode implementar a lógica de verificação das credenciais
        // para o banco de dados ou apenas retornar true se o username e senha
        // não estiverem vazios como exemplo.
        return !username.isEmpty() && !password.isEmpty(); // Exemplo simplificado
    }

    public String getUsername() {
        return usernameField.getText();
    }

    public String getPassword() {
        return new String(passwordField.getPassword());
    }
}
